package com.revature.dao;

import java.util.ArrayList;
import com.revature.pojos.*;

public interface BankDao
{

	public ArrayList<User> getUsers();
	public ArrayList<Account> getAccounts();
	public User getUserByName(String name);
	public Account getAccountByID(int id);
	public int createUser(User user);
	public int createAccount(Account account);
	public int createTransaction(Transaction transaction, int accountID);
	public int createLink(String username, int accountID);
	public int updateUser(User user);
	public int updateAccount(Account account);
	public int deleteUserByName(String name);
	public int deleteAccountByID(int accountID);
	public int deleteLink(String username, int accountID);
}
