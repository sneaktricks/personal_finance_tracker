# Personal Finance Tracker

Personal Finance Tracker is a cross-platform Flutter application that helps you effortlessly track your income and spending across various categories.
The application provides insights into your finances via all-time statistics, supported by persistent transaction storage, and
a quick glance at your monthly balance on the home page.

## Features

- See your current month balance on the home screen to quickly estimate your budget.
- Create income and expense entries, and categorize them.
- Check all your transaction entries, with the ability to filter by time.
- View individual transaction details and delete transactions.
- Display your all-time top income and expense categories by value to let you analyze your finances.
- Responsive UI, with two breakpoints and a maximum content width.
- Dark mode

## Try it Online

The application is available at https://flutter-finance-tracker-5a1d4.web.app/.

## User Manual

The application starts on the home page, which shows your current monthly balance. Depending on the width of your device, navigation is
performed:

- [Narrower screens (<768px)] Through the bottom navigation bar.
- [Wider screens (>=768px)] Through the navigation rail on the left-hand side of the application.

Textual labels on the navigation rail are shown on screens wider than 1024px.

### How do I add an entry?

1. Select "Add Entry" on the navigation bar/rail, or click the floating button with a plus icon in the bottom-right corner.
2. Your should now see the text "What type of entry do you want to add?" Choose either "Income" or "Expense" by clicking on either button.
3. Enter the value of your income/expense.
4. Choose a category for the entry by clicking on the dropdown menu.
5. Enter a date for the entry. The default date is today.
6. Click the button "Add income/expense" to save your entry.

### How do I see my entries?

1. On the navigation bar/rail, select "Transactions".
2. Drag the "Transaction date" slider to filter entries by time. The default range is all entries until now.
3. The entries are shown below the slider.

### How do I see the details of an entry?

1. On the navigation bar/rail, select "Transactions".
2. In the list view below the transaction date slider,
   click on your desired transaction.

### How do I delete an entry?

1. On the navigation bar/rail, select "Transactions".
2. In the list view below the transaction date slider,
   click on the entry you want to delete.
3. Click the "Delete" button below the transaction details.

### How do I see categorical statistics?

1. On the navigation bar/rail, select "Statistics".
2. At the top of the screen, select either "Income" or
   "Expenses".
3. Categorical statistics are shown in the table below.

## Known Issues

- On the all-time statistics page, the tab selector claims that the selected
  tab is always "income". This is a visual bug and doesn't affect the functionality of the app.
  I tried wrapping the ToggleButtons in an Obx widget, but this caused
  an "improper use of a GetX has been detected" error on Firebase. Oddly enough, this error doesn't occur
  in the development build.
- Newly added entries don't immediately appear in the transactions list. To fix this, drag either endpoint of the date
  filter slider to any other value and back.

- The navigation bar and rail are re-rendered on page change.
- The back button in the top-left corner shouldn't be rendered
  on pages with a navigation bar/rail. No idea why it's there...
- After deleting a transaction, clicking on the back button shows the
  deleted transaction again, despite being deleted. The transaction is indeed
  deleted from storage but the back-button seems to show an old state of the page.
- The code looks hideous, hacky, unintelligible spaghetti (I blame this on Dart and Flutter being bloated, GetX only complicates this further)
