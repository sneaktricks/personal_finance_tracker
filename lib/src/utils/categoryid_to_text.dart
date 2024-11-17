import 'package:flutter/material.dart';

/// Map of categoryIds to display names
const categoryIdToName = {
  // Income
  "salary": "Salary",
  "bonus": "Bonus/Commission",
  "freelance": "Freelance/Side Hustle",
  "investment": "Investment Income",
  "rental": "Rental Income",
  "business": "Business Income",
  "pension": "Pension/Social Security",
  "child_support": "Child Support",
  "gift": "Gift/Donation",
  // Expenses
  "housing": "Housing",
  "transportation": "Transportation",
  "groceries": "Food & Groceries",
  "entertainment": "Entertainment",
  "debt": "Debt Repayment",
  "insurance": "Insurance",
  "health": "Health & Wellness",
  "personal_care": "Personal Care",
  "education": "Education",
  "family": "Child & Family Care",
  "savings": "Savings & Investments",
  "other": "Other",
};

/// Map of categoryIds to icons
const categoryIdToIcon = {
  // Income
  "salary": Icons.work,
  "bonus": Icons.star,
  "freelance": Icons.build_circle,
  "investment": Icons.trending_up,
  "rental": Icons.home,
  "business": Icons.business,
  "pension": Icons.account_balance,
  "child_support": Icons.family_restroom,
  "gift": Icons.card_giftcard,
  // Expenses
  "housing": Icons.home,
  "transportation": Icons.directions_car,
  "groceries": Icons.shopping_cart,
  "entertainment": Icons.sports_esports,
  "debt": Icons.credit_card,
  "insurance": Icons.health_and_safety,
  "health": Icons.local_hospital,
  "personal_care": Icons.soap,
  "education": Icons.school,
  "family": Icons.child_care,
  "savings": Icons.savings,
  "other": Icons.monetization_on,
};

/// List of all income categories
const incomeCategories = [
  "salary",
  "bonus",
  "freelance",
  "investment",
  "rental",
  "business",
  "pension",
  "child_support",
  "gift",
  "other",
];

/// List of all expense categories
const expenseCategories = [
  "housing",
  "transportation",
  "groceries",
  "entertainment",
  "debt",
  "insurance",
  "health",
  "personal_care",
  "education",
  "family",
  "savings",
  "other",
];
