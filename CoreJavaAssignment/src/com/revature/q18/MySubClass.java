<<<<<<< HEAD
package com.revature.q18;

public class MySubClass extends MyAbstractClass {

	@Override
	public boolean caseCheck(String myString) {
		
		for(int i = 0; i < myString.length(); i++) {
			char c = myString.charAt(i);
			if (Character.isUpperCase(c)) {
				return true;
			}
		}  {
			return false;
		}
		
	}

	@Override
	public String makeUpper(String myString) {
		
		String result = myString.toUpperCase();
		return result;

	}

	@Override
	public int addTen(String myString) {
		
		int result = Integer.parseInt(myString);
		return result + 10;
	}

}
=======
package com.revature.q18;

public class MySubClass extends MyAbstractClass {

	@Override
	public boolean caseCheck(String myString) {
		
		for(int i = 0; i < myString.length(); i++) {
			char c = myString.charAt(i);
			if (Character.isUpperCase(c)) {
				return true;
			}
		}  {
			return false;
		}
		
	}

	@Override
	public String makeUpper(String myString) {
		
		String result = myString.toUpperCase();
		return result;

	}

	@Override
	public int addTen(String myString) {
		
		int result = Integer.parseInt(myString);
		return result + 10;
	}

}
>>>>>>> 70ec7955e736c9c2ea644fea4703f6f75b046dac
