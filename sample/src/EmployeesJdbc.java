import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

import com.mysql.fabric.jdbc.FabricMySQLConnection;
import com.mysql.fabric.proto.xmlrpc.XmlRpcClient;

public class EmployeesJdbc {
	private static final String URL = "jdbc:mysql:fabric://192.168.33.10:32274/mysql?" +
										"fabricServerGroup=fabric_test&fabricUsername=admin&fabricPassword=admin";
	private static final String USER = "fabric";
	private static final String PASS = "secret";
	private static FabricMySQLConnection con;
	private static Statement stat;
	
	public static void main(String[] args) throws Exception {
        con = (FabricMySQLConnection) DriverManager.getConnection(URL, USER, PASS);
        stat = con.createStatement();
        
		client();
		create();
		insert();
		select();
        delete();
        drop();
		
		stat.close();
        con.close();
	}

	

	private static void insert() throws Exception {
        con.setReadOnly(false);

        stat.executeUpdate("INSERT INTO employees.employees VALUES (1, 'John', 'Doe')");
        stat.executeUpdate("INSERT INTO employees.employees VALUES (2, 'Jane', 'Doe')");
        stat.executeUpdate("INSERT INTO employees.employees VALUES (10001, 'Andy', 'Wiley')");
        stat.executeUpdate("INSERT INTO employees.employees VALUES (10002, 'Alice', 'Wein')");
        
	}

	private static void select() throws Exception { 
        con.setReadOnly(true);
		
		stat.executeQuery("select * from employees.employees where emp_no = 1");
        stat.executeQuery("select * from employees.employees where emp_no = 2");
        stat.executeQuery("select * from employees.employees where emp_no = 10001");
        stat.executeQuery("select * from employees.employees where emp_no = 10002");
        
	}

	private static void delete() throws Exception {
        con.setReadOnly(false);

        stat.executeUpdate("delete from employees.employees where emp_no = 1");
        stat.executeUpdate("delete from employees.employees where emp_no = 2");
        stat.executeUpdate("delete from employees.employees where emp_no = 10001");
        stat.executeUpdate("delete from employees.employees where emp_no = 10002");   
    }
			
	private static void client() throws Exception {
        XmlRpcClient fabricClient = new XmlRpcClient("http://192.168.33.10:32274", "admin", "admin");
        System.out.println("Fabrics: " + fabricClient.getFabricNames());
        System.out.println("Groups: " + fabricClient.getGroupNames());
        for (String groupName : fabricClient.getGroupNames()) {
            System.out.println("Group def for '" + groupName + "': " + fabricClient.getServerGroup(groupName).toString().replaceAll("Serv", "\n\tServ"));
        }
        System.out.println("All servers: " + fabricClient.getServerGroups());		
	}
	
	private static void create() throws Exception {
        con.setReadOnly(false);

        stat.executeUpdate("create database if not exists employees");
        stat.executeUpdate("drop table if exists employees.employees");
        stat.executeUpdate("create table employees.employees (emp_no int not null, first_name varchar(50), last_name varchar(50), primary key (emp_no))");
	}

	private static void drop() throws Exception {
        con.setReadOnly(false);
        
        stat.executeUpdate("drop table if exists employees.employees");
	}
}
