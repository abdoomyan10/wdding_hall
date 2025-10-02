// features/payments/presentation/pages/payments_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../injection_container.dart';
import '../../domain/entities/payment_entity.dart';
import '../cubit/payment_cubit.dart';
import '../widgets/Add_Payment_Dialog.dart';

class PaymentsPage extends StatelessWidget {
  const PaymentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<PaymentCubit>()..loadPayments(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('المدفوعات'),
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.white,
          elevation: 0,
          actions: [
            IconButton(
              icon: const Icon(Icons.filter_alt),
              onPressed: () => _showFilterDialog(context),
              tooltip: 'تصفية المدفوعات',
            ),
          ],
        ),
        body: const Column(
          children: [
            _PaymentStatsSection(),
            _PaymentFilters(),
            Expanded(child: _PaymentsList()),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _showAddPaymentDialog(context),
          backgroundColor: AppColors.primary,
          child: const Icon(Icons.add, color: AppColors.white),
        ),
      ),
    );
  }

  static void _showAddPaymentDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => const AddPaymentDialog(),
    );
  }

  static void _showFilterDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => const _PaymentFilterDialog(),
    );
  }
}

class _PaymentStatsSection extends StatelessWidget {
  const _PaymentStatsSection();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PaymentCubit, PaymentState>(
      builder: (context, state) {
        if (state is PaymentLoaded && state.stats != null) {
          final stats = state.stats!;
          return Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.05),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Column(
              children: [
                // الصف الأول من الإحصائيات
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _StatItem(
                      value: '${stats.totalReceived.toStringAsFixed(0)} ر.س',
                      label: 'إجمالي المستلم',
                      icon: Icons.check_circle,
                      color: AppColors.success,
                    ),
                    _StatItem(
                      value: '${stats.totalPending.toStringAsFixed(0)} ر.س',
                      label: 'المدفوعات المعلقة',
                      icon: Icons.pending,
                      color: AppColors.warning,
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                // الصف الثاني من الإحصائيات
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _StatItem(
                      value: stats.completedPayments.toString(),
                      label: 'مدفوعات مكتملة',
                      icon: Icons.payment,
                      color: AppColors.info,
                    ),
                    _StatItem(
                      value: stats.pendingPayments.toString(),
                      label: 'مدفوعات معلقة',
                      icon: Icons.schedule,
                      color: AppColors.primary,
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                // شريط التقدم
                LinearProgressIndicator(
                  value: stats.totalExpected > 0
                      ? stats.totalReceived / stats.totalExpected
                      : 0,
                  backgroundColor: AppColors.gray200,
                  valueColor: AlwaysStoppedAnimation<Color>(AppColors.success),
                ),
                const SizedBox(height: 8),
                Text(
                  'نسبة الإنجاز: ${((stats.totalReceived / stats.totalExpected) * 100).toStringAsFixed(1)}%',
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.gray500,
                  ),
                ),
              ],
            ),
          );
        }
        return const SizedBox();
      },
    );
  }
}

class _StatItem extends StatelessWidget {
  final String value;
  final String label;
  final IconData icon;
  final Color color;

  const _StatItem({
    required this.value,
    required this.label,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color, size: 20),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: AppColors.gray500,
          ),
        ),
      ],
    );
  }
}

class _PaymentFilters extends StatelessWidget {
  const _PaymentFilters();

  @override
  Widget build(BuildContext context) {
    final statusFilters = [
      {'key': 'all', 'text': 'الكل', 'icon': Icons.all_inclusive},
      {'key': 'completed', 'text': 'مكتمل', 'icon': Icons.check_circle},
      {'key': 'pending', 'text': 'معلق', 'icon': Icons.pending},
      {'key': 'failed', 'text': 'فاشل', 'icon': Icons.error},
    ];

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      color: AppColors.white,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: statusFilters.map((filter) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: FilterChip(
                label: Text(filter['text'] as String),
                avatar: Icon(filter['icon'] as IconData, size: 16),
                onSelected: (selected) {
                  // TODO: تطبيق التصفية حسب الحالة
                  if (filter['key'] == 'all') {
                    context.read<PaymentCubit>().loadPayments();
                  }
                },
                backgroundColor: AppColors.gray200,
                selectedColor: AppColors.primary.withOpacity(0.2),
                labelStyle: const TextStyle(fontSize: 12),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

class _PaymentsList extends StatelessWidget {
  const _PaymentsList();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PaymentCubit, PaymentState>(
      builder: (context, state) {
        if (state is PaymentLoading) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 16),
                Text('جاري تحميل المدفوعات...'),
              ],
            ),
          );
        } else if (state is PaymentLoaded) {
          if (state.payments.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.payment, size: 64, color: AppColors.gray500),
                  SizedBox(height: 16),
                  Text(
                    'لا توجد مدفوعات',
                    style: TextStyle(fontSize: 18, color: AppColors.gray500),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'انقر على زر + لإضافة دفعة جديدة',
                    style: TextStyle(fontSize: 14, color: AppColors.gray500),
                  ),
                ],
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () async {
              context.read<PaymentCubit>().loadPayments();
            },
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: state.payments.length,
              itemBuilder: (context, index) {
                final payment = state.payments[index];
                return _PaymentCard(payment: payment);
              },
            ),
          );
        } else if (state is PaymentError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline, size: 64, color: AppColors.error),
                const SizedBox(height: 16),
                Text(
                  state.message,
                  style: const TextStyle(fontSize: 16, color: AppColors.error),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    context.read<PaymentCubit>().loadPayments();
                  },
                  child: const Text('إعادة المحاولة'),
                ),
              ],
            ),
          );
        }
        return const Center(child: Text('مرحباً بك في إدارة المدفوعات'));
      },
    );
  }
}

class _PaymentCard extends StatelessWidget {
  final PaymentEntity payment;

  const _PaymentCard({required this.payment});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // الصف الأول: اسم العميل وحالة الدفع
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    payment.clientName,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.black,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: payment.statusColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: payment.statusColor.withOpacity(0.3)),
                  ),
                  child: Text(
                    payment.statusText,
                    style: TextStyle(
                      color: payment.statusColor,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),

            // الصف الثاني: اسم الحفلة
            Text(
              payment.eventName,
              style: const TextStyle(
                fontSize: 14,
                color: AppColors.gray500,
              ),
            ),
            const SizedBox(height: 12),

            // الصف الثالث: المبلغ وتاريخ الدفع
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${payment.amount.toStringAsFixed(0)} ر.س',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
                Row(
                  children: [
                    const Icon(Icons.calendar_today, size: 16, color: AppColors.gray500),
                    const SizedBox(width: 4),
                    Text(
                      DateFormat('yyyy-MM-dd').format(payment.paymentDate),
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppColors.gray500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 8),

            // الصف الرابع: طريقة الدفع والملاحظات
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.gray100,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    payment.paymentMethodText,
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.gray500,
                    ),
                  ),
                ),
                if (payment.notes.isNotEmpty)
                  Expanded(
                    child: Text(
                      payment.notes,
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.gray500,
                      ),
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.end,
                    ),
                  ),
              ],
            ),

            // زر الإجراءات
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit, size: 18),
                  onPressed: () => _showEditPaymentDialog(context, payment),
                  color: AppColors.info,
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(Icons.delete, size: 18),
                  onPressed: () => _showDeleteConfirmation(context, payment.id),
                  color: AppColors.error,
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showEditPaymentDialog(BuildContext context, PaymentEntity payment) {
    showDialog(
      context: context,
      builder: (context) => AddPaymentDialog(paymentToEdit: payment),
    );
  }

  void _showDeleteConfirmation(BuildContext context, String paymentId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('تأكيد الحذف'),
        content: const Text('هل أنت متأكد من حذف هذه الدفعة؟'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('إلغاء'),
          ),
          TextButton(
            onPressed: () {
              context.read<PaymentCubit>().deletePayment(paymentId);
              Navigator.of(context).pop();
            },
            child: const Text('حذف', style: TextStyle(color: AppColors.error)),
          ),
        ],
      ),
    );
  }
}

class _PaymentFilterDialog extends StatefulWidget {
  const _PaymentFilterDialog();

  @override
  State<_PaymentFilterDialog> createState() => _PaymentFilterDialogState();
}

class _PaymentFilterDialogState extends State<_PaymentFilterDialog> {
  DateTime _startDate = DateTime.now().subtract(const Duration(days: 30));
  DateTime _endDate = DateTime.now();
  String? _selectedStatus = 'all';
  String? _selectedPaymentMethod = 'all';

  final List<Map<String, dynamic>> _statuses = [
    {'value': 'all', 'text': 'الكل'},
    {'value': 'completed', 'text': 'مكتمل'},
    {'value': 'pending', 'text': 'معلق'},
    {'value': 'failed', 'text': 'فاشل'},
  ];

  final List<Map<String, dynamic>> _paymentMethods = [
    {'value': 'all', 'text': 'الكل'},
    {'value': 'cash', 'text': 'نقدي'},
    {'value': 'bank_transfer', 'text': 'تحويل بنكي'},
    {'value': 'credit_card', 'text': 'بطاقة ائتمان'},
  ];

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('تصفية المدفوعات'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // فلترة حسب التاريخ
            const Align(
              alignment: Alignment.centerRight,
              child: Text(
                'الفترة الزمنية:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            ListTile(
              title: const Text('من تاريخ'),
              subtitle: Text(DateFormat('yyyy-MM-dd').format(_startDate)),
              trailing: const Icon(Icons.calendar_today),
              onTap: () async {
                final selectedDate = await showDatePicker(
                  context: context,
                  initialDate: _startDate,
                  firstDate: DateTime(2020),
                  lastDate: DateTime(2030),
                );
                if (selectedDate != null) {
                  setState(() {
                    _startDate = selectedDate;
                  });
                }
              },
            ),
            ListTile(
              title: const Text('إلى تاريخ'),
              subtitle: Text(DateFormat('yyyy-MM-dd').format(_endDate)),
              trailing: const Icon(Icons.calendar_today),
              onTap: () async {
                final selectedDate = await showDatePicker(
                  context: context,
                  initialDate: _endDate,
                  firstDate: DateTime(2020),
                  lastDate: DateTime(2030),
                );
                if (selectedDate != null) {
                  setState(() {
                    _endDate = selectedDate;
                  });
                }
              },
            ),
            const SizedBox(height: 16),

            // فلترة حسب الحالة
            const Align(
              alignment: Alignment.centerRight,
              child: Text(
                'حالة الدفع:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            DropdownButtonFormField<String?>(
              value: _selectedStatus,
              items: _statuses.map((status) {
                return DropdownMenuItem<String?>(
                  value: status['value'],
                  child: Text(status['text']),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedStatus = value;
                });
              },
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            // فلترة حسب طريقة الدفع
            const Align(
              alignment: Alignment.centerRight,
              child: Text(
                'طريقة الدفع:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            DropdownButtonFormField<String?>(
              value: _selectedPaymentMethod,
              items: _paymentMethods.map((method) {
                return DropdownMenuItem<String?>(
                  value: method['value'],
                  child: Text(method['text']),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedPaymentMethod = value;
                });
              },
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('إلغاء'),
        ),
        ElevatedButton(
          onPressed: () {
            // TODO: تطبيق الفلترة
            Navigator.of(context).pop();
          },
          child: const Text('تطبيق الفلترة'),
        ),
      ],
    );
  }
}