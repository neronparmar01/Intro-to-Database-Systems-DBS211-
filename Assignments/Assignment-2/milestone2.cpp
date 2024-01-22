/*
MILESTONE 2 :
GROUP MEMBERS NAME
NAME : PARMAR NERON NELSON   STUDENT ID : 171690217    EMAIL : nparmar22@myseneca.ca
NAME : ADITYA JASUJA         STUDENT ID : 172043218    EMAIL : ajasuja@myseneca.ca
NAME : AARUSHI SOOD          STUDENT ID : 167032218    EMAIL : asood35@myseneca.ca
Date : 4/12/22
*/

#define _CRT_SECURE_NO_WARNINGS

#include <iostream>
#include <occi.h>
#include <string.h>
#include <cstring>
using oracle::occi::Environment;
using oracle::occi::Connection;
using namespace oracle::occi;
using namespace std;


struct Employee
{
	int  employeeNumber;
	char lastName[50];
	char firstName[50];
	char extension[10];
	char email[100];
	char officecode[10];
	int  reportsTo;
	char jobTitle[50];
};


int getInt(const char* prompt);
int findEmployee(Connection* conn, int employeeNumber, struct Employee* emp);
void displayEmployee(Connection* conn, struct Employee emp);
int menu(void);
void displayAllEmployees(Connection* conn);

int main(void)
{
	int usr_opt = 0;
	bool check = true;
	/* OCCI Variables */
	Environment* env = nullptr;
	Connection* conn = nullptr;
	/* Used Variables */
	string user = "dbs211_223zdd28";
	string pass = "15131453";
	string constr = "myoracle12c.senecacollege.ca:1521/oracle12c";

	try {
		env = Environment::createEnvironment(Environment::DEFAULT);
		conn = env->createConnection(user, pass, constr);

	  if (conn)
        {
            cout << " * ------ Group ------ * " << "\n";
            cout << "Group Members Details :- " << "\n";
            cout << "MEMBER 1 -> Name : Parmar Neron Nelson" << "\n";
            cout << "MEMBER 2 -> Name : Aditya Jasuja" << "\n";
            cout << "MEMBER 3 -> Name : Aarushi Sood" << "\n";
        }

		while (check)
		{
			usr_opt = menu();
			int employeeNum;
			switch (usr_opt)
			{
			case 1:
				employeeNum = getInt("Enter Employee Number: ");
				Employee emp1;
				if (findEmployee(conn, employeeNum, &emp1))
				{
					displayEmployee(conn, emp1);
				}
				else
					cout << "Employee " << employeeNum << " does not exist." << endl << endl;
				break;
			case 2:
				displayAllEmployees(conn);
				cout << endl;
				break;
				
			default:
				cout << endl << "Exiting the application..." << endl;
				check = false;
				break;
			}
		}
		env->terminateConnection(conn);
		Environment::terminateEnvironment(env);
	}
	catch (SQLException& sqlExcp) {
		cout << "error";
		cout << sqlExcp.getErrorCode() << ": " << sqlExcp.getMessage();
	}

	return 0;
}



int menu(void)
{
	cout << "********************* HR Menu *********************" << endl;
	cout << "1) Find Employee" << endl;
	cout << "2) Employees Report" << endl;
	cout << "3) Add Employee" << endl;
	cout << "4) Update Employee" << endl;
	cout << "5) Remove Employee" << endl;
	cout << "0) Exit" << endl;
	cout << "Enter an option (0-5): ";

	int usr_opt = 0;
	bool check = true;
	char letter = 'X';

	while (check) {
		cin >> usr_opt;
		letter = cin.get();
		if (cin.fail()) {
			cout << "Bad integer value, try again: ";
			cin.clear();
			cin.ignore(1000, '\n');
		}
		else if (letter != '\n') {
			cout << "Enter only an integer, try again: ";
			cin.clear();
			cin.ignore(1000, '\n');
		}
		else if (0 > usr_opt || usr_opt > 5) {
			cout << "Enter an option (0-5): ";
		}
		else {
			check = false;
		}
	}
	return usr_opt;
}


void displayAllEmployees(Connection* conn)
{
	Statement* stmt = nullptr;
	stmt = conn->createStatement();

	ResultSet* rs = nullptr;
	rs = stmt->executeQuery("SELECT e.employeenumber AS ID, e.firstname || ' ' || e.lastname AS \"Employee Name\", e.email, o.phone, e.extension, d.firstname || ' ' || d.lastname AS \"Manager Name\" FROM dbs211_employees e JOIN dbs211_offices o ON e.officecode = o.officecode Left OUTER JOIN dbs211_employees d ON e.reportsto = d.employeenumber ORDER BY e.employeenumber");

	if (!rs->next())
	{
		cout << "ResultSet is empty." << endl;
	}
	else {
		cout << "------   ---------------    ---------------------------------  ----------------  ---------   -----------------" << endl;
		cout << "ID       Employee Name      Email                              Phone             Extension   Manager          " << endl;
		cout << "-----    ---------------    ---------------------------------  ----------------  ---------   -----------------" << endl;
		do {
			int id = rs->getInt(1);
			string name = rs->getString(2);
			string email = rs->getString(3);
			string phone = rs->getString(4);
			string extension = rs->getString(5);
			string managerName = rs->getString(6);

			cout.setf(ios::left);
			cout.width(9);
			cout << id;
			cout.unsetf(ios::left);

			cout.setf(ios::left);
			cout.width(19);
			cout << name;
			cout.unsetf(ios::left);

			cout.setf(ios::left);
			cout.width(35);
			cout << email;
			cout.unsetf(ios::left);

			cout.setf(ios::left);
			cout.width(18);
			cout << phone;
			cout.unsetf(ios::left);

			cout.setf(ios::left);
			cout.width(12);
			cout << extension;
			cout.unsetf(ios::left);

			cout << managerName << endl;
		} while (rs->next());
	}
}


int findEmployee(Connection* conn, int employeeNumber, Employee* emp)
{
	int res = 0;
	Statement* stmt = conn->createStatement();
	stmt->setSQL("SELECT * FROM dbs211_employees where employeenumber=:1");
	stmt->setInt(1, employeeNumber);
	ResultSet* rs = stmt->executeQuery();
	if (rs->next())
	{
		res = 1;
		if (emp)
		{
			emp->employeeNumber = rs->getInt(1);
			strncpy_s(emp->lastName, rs->getString(2).c_str(), 49);
			strncpy_s(emp->firstName, rs->getString(3).c_str(), 49);
			strncpy_s(emp->extension, rs->getString(4).c_str(), 9);
			strncpy_s(emp->email, rs->getString(5).c_str(), 99);
			strncpy_s(emp->officecode, rs->getString(6).c_str(), 9);
			emp->reportsTo = rs->getInt(7);
			strncpy_s(emp->jobTitle, rs->getString(8).c_str(), 49);
		}
	}
	conn->terminateStatement(stmt);
	return res;
}


void displayEmployee(Connection* conn, Employee ep)
{
	cout << endl << "-------------- Employee Information -------------" << endl;
	cout << "Employee Number: " << ep.employeeNumber << endl;
	cout << "Last Name: " << ep.lastName << endl;
	cout << "First Name: " << ep.firstName << endl;
	cout << "Extenstion: " << ep.extension << endl;
	cout << "Email: " << ep.email << endl;
	cout << "Office Code: " << ep.officecode << endl;
	cout << "Manager ID: " << ep.reportsTo << endl;
	cout << "Job Title: " << ep.jobTitle << endl << endl;
}

//Implementing the utility function for getting correct input from the user to select the valid option
int getInt(const char* prompt)
{
	int val;
	int flag = 0;
	if (prompt)
		cout << prompt;
	do {
		cin >> val;
		if (cin.fail())
		{
			cout << "Bad integer value, try again: ";
			cin.clear();
			while (cin.get() != '\n');
		}
		else if (cin.get() != '\n')
		{
			cout << "Enter only an integer, try again: ";
			while (cin.get() != '\n');
		}
		else flag = 1;

	} while (flag == 0);
	return val;
}

