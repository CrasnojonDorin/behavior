enum LoanType { personal, business, mortgage, testType }

class Loan {
  final LoanType type;
  final double amount;

  Loan(this.type, this.amount);
}

abstract class LoanHandler {
  LoanHandler? _nextHandler;

  void setNextHandler(LoanHandler nextHandler) {
    _nextHandler = nextHandler;
  }

  void processLoan(Loan loan);
}

class PersonalLoanHandler extends LoanHandler {
  @override
  void processLoan(Loan loan) {
    if (loan.type == LoanType.personal) {
      print('Personal loan processed by PersonalLoanHandler');
    } else if (_nextHandler != null) {
      _nextHandler!.processLoan(loan);
    } else {
      print('Loan type not supported');
    }
  }
}

class BusinessLoanHandler extends LoanHandler {
  @override
  void processLoan(Loan loan) {
    if (loan.type == LoanType.business) {
      print('Business loan processed by BusinessLoanHandler');
    } else if (_nextHandler != null) {
      _nextHandler!.processLoan(loan);
    } else {
      print('Loan type not supported');
    }
  }
}

class MortgageLoanHandler extends LoanHandler {
  @override
  void processLoan(Loan loan) {
    if (loan.type == LoanType.mortgage) {
      print('Mortgage loan processed by MortgageLoanHandler');
    } else if (_nextHandler != null) {
      _nextHandler!.processLoan(loan);
    } else {
      print('Loan type not supported');
    }
  }
}

void main() {
  final personalLoanHandler = PersonalLoanHandler();
  final businessLoanHandler = BusinessLoanHandler();
  final mortgageLoanHandler = MortgageLoanHandler();

  personalLoanHandler.setNextHandler(businessLoanHandler);
  businessLoanHandler.setNextHandler(mortgageLoanHandler);

  final personalLoan = Loan(LoanType.personal, 5000.0);
  final businessLoan = Loan(LoanType.business, 100000.0);
  final mortgageLoan = Loan(LoanType.mortgage, 300000.0);

  personalLoanHandler.processLoan(personalLoan);
  personalLoanHandler.processLoan(businessLoan);
  personalLoanHandler.processLoan(mortgageLoan);

  final incorectLoan = Loan(LoanType.testType, 300000.0);
  personalLoanHandler.processLoan(incorectLoan);
}
