/*
Name : Neron Nelson Parmar
Student ID : 171690217
email ID : nparmar22@myseneca.ca
Date : 6/11/22
*/

#include <iostream>
#include <occi.h>

using oracle::occi::Environment;
using oracle::occi::Connection;
using namespace oracle::occi;
using namespace std;

int main(void)
{
    /* OCCI Variables */
    Environment* env = nullptr;
    Connection* conn = nullptr;
    /* Used Variables */
    string str;
    string user = "dbs211_223zbb29";
    string pass = "16477456";
    string constr = "myoracle12c.senecacollege.ca:1521/oracle12c";
    try {
        env = Environment::createEnvironment(Environment::DEFAULT);
        conn = env->createConnection(user, pass, constr);
        cout << "Connection is Successful!" << endl;
        // 1 st output statements
      Statement* stmt = conn->createStatement();

        ResultSet* rs = stmt->executeQuery("SELECT e.employeenumber, e.firstname||' '||e.lastname AS Name, o.phone, e.Extension FROM dbs211_employees e, dbs211_offices o WHERE e.officecode = 1 AND o.officecode = 1 ORDER BY e.employeenumber");
        cout << "********** Employee Report **********" << endl;
        cout << "Employee Report: " << endl;

        while (rs->next())
        {
            int id = rs->getInt(1); // get the first column as int
            string name = rs->getString(2);
            string phone = rs->getString(3);
            string extension = rs->getString(4);
            cout << "ID: " << id << "     " << "Name: " << name << "      " << "Phone: " << phone << "      " << "Extension: " << extension << "      " << endl;
        }

        cout << endl;

        // end of 1 st output 

        //2nd output
        Statement* stmt = conn->createStatement();

        ResultSet* rs = stmt->executeQuery("SELECT e.employeenumber, e.firstname||' '||e.lastname AS Name, o.phone, e.Extension FROM dbs211_employees e INNER JOIN dbs211_offices o ON e.officecode=o.officecode WHERE e.jobtitle LIKE '%Manager' OR e.reportsto IS NULL OR e.reportsto = '1002' OR e.reportsto = '1056' ORDER BY e.employeenumber");

        cout << " * *********Manager Report * *********"<< endl;
        cout << "Manager Report: " << endl;

        while (rs->next())
        {
            int id = rs->getInt(1); // get the first column as int
            string name = rs->getString(2);
            string phone = rs->getString(3);
            string extension = rs->getString(4);
            cout << "ID: " << id << "     " << "Name: " << name << "      " << "Phone: " << phone << "      " << "Extension: " << extension << "      " << endl;
        }
        cout << endl;

        conn->terminateStatement(stmt);
        env->terminateConnection(conn);
        Environment::terminateEnvironment(env);
    }
    catch (SQLException& sqlExcp) {
        cout << sqlExcp.getErrorCode() << ": " << sqlExcp.getMessage();
    }
    return 0;
}
