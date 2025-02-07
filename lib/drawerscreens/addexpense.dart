import 'package:flutter/material.dart';
import 'package:pos/constants.dart';

class AddExpense extends StatefulWidget {
  const AddExpense({super.key});

  @override
  State<AddExpense> createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<Map<String, String>> expenseCategories = [
    {"name": "Rent"},
    {"name": "Food"},
    {"name": "Transport"},
    {"name": "Shopping"},
    {"name": "Bills"},
    {"name": "Miscellaneous"},
  ];

  final List<Map<String, String>> incomeCategories = [
    {"name": "Salary"},
    {"name": "Awards"},
    {"name": "Investments"},
    {"name": "Freelance"},
    {"name": "Gifts"},
    {"name": "Other"},
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  // Function to show popup for entering amount
  void _showAmountPopup(String category, bool isExpense) {
    TextEditingController amountController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(category), // Category name as heading
          content: TextField(
            controller: amountController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(hintText: "Enter amount"),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: isExpense ? Colors.red : Colors.green, // Red for expense, Green for income
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              onPressed: () {
                String amount = amountController.text.trim();
                if (amount.isNotEmpty) {
                  // Handle adding the expense/income logic
                  Navigator.pop(context);
                }
              },
              child: Text(
                isExpense ? "Add Expense" : "Add Income",
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }

  // Function to show add category popup
  void _showAddCategoryDialog(bool isExpense) {
    TextEditingController categoryController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Add ${isExpense ? "Expense" : "Income"} Category"),
          content: TextField(
            controller: categoryController,
            decoration: const InputDecoration(hintText: "Enter category name"),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                String newCategory = categoryController.text.trim();
                if (newCategory.isNotEmpty) {
                  setState(() {
                    if (isExpense) {
                      expenseCategories.add({"name": newCategory});
                    } else {
                      incomeCategories.add({"name": newCategory});
                    }
                  });
                  Navigator.pop(context);
                }
              },
              child: const Text("Add"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: TabBar(
          controller: _tabController,
          labelColor: primaryColor,
          unselectedLabelColor: Colors.grey, // Unselected tab text color
          indicatorColor: primaryColor, // Selected tab underline color
          tabs: const [
            Tab(text: "Expense"),
            Tab(text: "Income"),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildGridView(expenseCategories, isExpense: true),
          _buildGridView(incomeCategories, isExpense: false),
        ],
      ),
    );
  }

  Widget _buildGridView(List<Map<String, String>> categories, {required bool isExpense}) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: GridView.builder(
        itemCount: categories.length + 1, // +1 for the add button
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 0.8,
        ),
        itemBuilder: (context, index) {
          if (index == categories.length) {
            // Add Button
            return GestureDetector(
              onTap: () => _showAddCategoryDialog(isExpense),
              child: Card(
                
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: primaryColor,
                      child: Icon(Icons.add, size: 30, color: Colors.white,
                    ),
                    ),
                    SizedBox(height: 8),
                    Text("Add", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                  ],
                ),
              ),
            );
          }

          String name = categories[index]["name"]!;
          return GestureDetector(
            onTap: () => _showAmountPopup(name, isExpense), // Show popup on tap
            child: Card(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: secondcolor,
                    child: Text(
                      name[0], // First letter of category
                      style: const TextStyle(fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    name,
                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
