abstract class Element {
  void accept(Visitor visitor);
}

abstract class Visitor {
  void visitEmployee(Employee employee);
  void visitDepartment(Department department);
}

class Employee implements Element {
  final String name;
  final double salary;
  final int yearsOfExperience;

  Employee(this.name, this.salary, this.yearsOfExperience);

  @override
  void accept(Visitor visitor) {
    visitor.visitEmployee(this);
  }
}

class Department implements Element {
  final String name;
  final List<Employee> employees = [];

  Department(this.name);

  void addEmployee(Employee employee) {
    employees.add(employee);
  }

  @override
  void accept(Visitor visitor) {
    visitor.visitDepartment(this);
  }
}

class SalaryCalculator implements Visitor {
  double totalSalary = 0;

  @override
  void visitEmployee(Employee employee) {
    totalSalary += employee.salary;
  }

  @override
  void visitDepartment(Department department) {
    for (var employee in department.employees) {
      employee.accept(this);
    }
  }
}

void main() {
  var department = Department("HR");
  var employee1 = Employee("John Doe", 5000, 2);
  var employee2 = Employee("Jane Smith", 6000, 4);
  department.addEmployee(employee1);
  department.addEmployee(employee2);

  var salaryCalculator = SalaryCalculator();
  department.accept(salaryCalculator);
  print(
      "Total salary for ${department.name} department is ${salaryCalculator.totalSalary}");
}
