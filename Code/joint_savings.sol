// SPDX-License-Identifier: MIT

/*
Joint Savings Account
---------------------

To automate the creation of joint savings accounts, you will create a solidity smart contract that accepts two user addresses 
that are then able to control a joint savings account. Your smart contract will use ether management functions to implement various requirements 
from the financial institution to provide the features of the joint savings account.

The Starting file provided for this challenge contains a `pragma` for solidity version `5.0.0`.
You will do the following:

1. Create and work within a local blockchain development environment using the JavaScript VM provided by the Remix IDE.

2. Script and deploy a **JointSavings** smart contract.

3. Interact with your deployed smart contract to transfer and withdraw funds.

*/

pragma solidity ^0.5.7;
contract JointSavings {
    
    // Declare two payable addresses for the joint account holders
    address payable accountOne;
    address payable accountTwo;
    
    // Variables to keep track of the last withdrawal recipient, amount, and contract balance
    address public lastToWithdraw;
    uint public lastWithdrawAmount;
    uint public contractBalance;
    
    // Function to allow a withdrawal from the joint account
    function withdraw(uint amount, address payable recipient) public {
        // Require that the recipient is one of the account holders
        require(recipient == accountOne || recipient == accountTwo, "You don't own this account!");
        // Require that the contract has sufficient funds for the withdrawal
        require(address(this).balance >= amount, "Insufficient funds!");
        // Update the last withdrawal recipient if it's different from the current one
        if (lastToWithdraw != recipient){
            lastToWithdraw = recipient;
        }
        // Transfer the specified amount to the recipient
        recipient.transfer(amount);
        // Update the last withdrawal amount and contract balance
        lastWithdrawAmount = amount;
        contractBalance = address(this).balance;
    }
    
    // Function to deposit ether into the joint account
    function deposit() public payable {
        // Update the contract balance with the received amount
        contractBalance = address(this).balance;
    }
    
    // Function to set the account addresses for the joint account
    function setAccounts(address payable account1, address payable account2) public {
        // Set the values of `accountOne` and `accountTwo` to `account1` and `account2`, respectively
        accountOne = account1;
        accountTwo = account2;
    }
    
    // Fallback function to allow the contract to receive ether
    function() external payable {}
}
