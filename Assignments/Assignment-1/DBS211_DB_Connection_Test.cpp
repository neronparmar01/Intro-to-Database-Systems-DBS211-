/*
MILESTONE 1 :
GROUP MEMBERS NAME
NAME : PARMAR NERON NELSON   STUDENT ID : 171690217    EMAIL : nparmar22@myseneca.ca  
NAME : ADITYA JASUJA         STUDENT ID : 172043218    EMAIL : ajasuja@myseneca.ca  
NAME : AARUSHI SOOD          STUDENT ID : 167032218    EMAIL : asood35@myseneca.ca
Date : 9/11/22
*/

#define _CRT_SECURE_NO_WARNINGS
#include <iostream>
#include <occi.h>
#include <iomanip>
#include <string>


#include <windows.h>
#include <sqlext.h>
#include <sqltypes.h>
#include <sql.h>


using oracle::occi::Environment;
using oracle::occi::Connection;
using namespace oracle::occi;
using namespace std;



struct Employee {
    int employeeNumber;
    char lastName[50];
    char firstName[50];
    char email[100];
    char phone[50];
    char extension[10];
    char reportsTo[100];
    char jobTitle[50];
    char city[50];
};

int menu(void);
int findEmployee(Connection* conn, int employeeNumber, struct Employee* emp);
void displayEmployee(Connection* conn, struct Employee* emp);
void displayAllEmployees(Connection* conn);
int getPositive(int max, int min);	// Utility function to get a positive number from user prompt
void getStringInput(int length, char* field);  // Utility function to get string from user prompt






int main(void)
{
    /* OCCI Variables 
    Environment* env = nullptr;
    Connection* conn = nullptr;
    /* Used Variables 
    string user = "dbs211_223zdd28";
    string pass = "15131453";
    string constr = "myoracle12c.senecacollege.ca:1521/oracle12c";
    try {
        env = Environment::createEnvironment(Environment::DEFAULT);
        conn = env->createConnection(user, pass, constr);
        cout << "Connection is Successful!" << endl;
        env->terminateConnection(conn);
        Environment::terminateEnvironment(env);

        if (conn)
        {
            cout << " * ------ Group ------ * " << "\n";
            cout << "Group Members Details :- " << "\n";
            cout << "MEMBER 1 -> Name : Parmar Neron Nelson" << "\n";
            cout << "MEMBER 2 -> Name : Aditya Jasuja" << "\n";
            cout << "MEMBER 3 -> Name : Aarushi Sood" << "\n";
        }


    }
    catch (SQLException& sqlExcp) {
        cout << sqlExcp.getErrorCode() << ": " << sqlExcp.getMessage();
    }*/
    Environment* env = nullptr;
    Connection* conn = nullptr;
    //Statement* stmt = nullptr;
   // ResultSet* rs = nullptr;

    string str;
    string usr = "dbs211_202c25";
    string pass = "14013167";
    string srv = "myoracle12c.senecacollege.ca:1521/oracle12c";
    int userPromptInput = 0;

    try {
        env = Environment::createEnvironment(Environment::DEFAULT);
        conn = env->createConnection(usr, pass, srv);
        cout << "Connection is successful\n" << endl;
        Statement* stmt = conn->createStatement();

        struct Employee emp = { 0, "", "" , "" , "" , "" , "" , "" , "" };
        int pass = 0;

        do {
            int chMenu = menu();
            if (chMenu == 6) {	// Exit
                cout << "Terminating the system. Goodbye " << usr << endl;
                pass = 1;
            }
            else if (chMenu == 1) {
                // Find Employee
                cout << "Employee Number: ";
                int employeeNum = getPositive(9999, 1);	// user Input for searching employee number
                int returnedValue = findEmployee(conn, employeeNum, &emp);	// call findEmployee function
                if (returnedValue != 0) {	// If the searching user exists in DB
                    displayEmployee(conn, &emp);	// Display (single) user information
                }
                else {	// If the searching user does not exist in DB
                    cout << "Employee " << employeeNum << " does not exist" << endl;
                }
            }
            else if (chMenu == 2) {	// Employees Report
                displayAllEmployees(conn);
            }
            else if (chMenu == 3) {	// Add Employee
                cout << "Employee Number: ";
                emp.employeeNumber = getPositive(9999, 1);	// user Input for employee number
                cout << "Last Name: ";
                getStringInput(50, emp.lastName);	// user Input for last name
                cout << "First Name: ";
                getStringInput(50, emp.firstName);	// user Input for first name
                cout << "Email: ";
                getStringInput(100, emp.email);	// user Input for email
                cout << "extension: ";
                getStringInput(10, emp.extension);	// user Input for extension
                cout << "Job Title: ";
                getStringInput(50, emp.jobTitle);	// user Input for job title
                cout << "City: ";
              
   
        } while (pass == 0);

        conn->terminateStatement(stmt);
        env->terminateConnection(conn);
        Environment::terminateEnvironment(env);
    }

    catch (SQLException& sqlExcp)
    {
        cout << sqlExcp.getErrorCode() << ": " << sqlExcp.getMessage();
    }
    return 0;
}

