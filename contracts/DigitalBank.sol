// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.7;
contract DigitalBank {
    
    struct Account {
        address payable ownerAccount;
        uint ownerBalance;
        string accountHolderName;
        uint accountCreationTime;
        string accountStatus;
    }
    
    mapping(address =>Account) public  DigiAccount;
    mapping(address => bool) public accountStatus;
    event addFunds (address indexed ownerAccount, uint funds, uint timeofTransaction);
    event withdrawFunds (address indexed ownerAccount,address indexed toTransfer, uint funds, uint timeofTransaction);

    function activateYourAccount(string memory _accountholderName) public returns (bool) {
        require(accountStatus[msg.sender]==false,"You have Already Account");
        DigiAccount[msg.sender].ownerAccount= payable(msg.sender);
        DigiAccount[msg.sender].ownerBalance= 0;
        DigiAccount[msg.sender].accountHolderName= _accountholderName;
        DigiAccount[msg.sender].accountCreationTime= block.timestamp;
        accountStatus[msg.sender]= true;
         return true;
    }
    function depositAmount() public payable {
        require(msg.sender==DigiAccount[msg.sender].ownerAccount,"Create Account First");
        require(msg.value> 0,"Please select valid Amount");
        DigiAccount[msg.sender].ownerBalance +=msg.value;
        emit addFunds (msg.sender,msg.value,block.timestamp);
    }
    function sendAmountTo(address _address,uint _amount) public payable returns(bool) {
        require(_address==DigiAccount[_address].ownerAccount,"Beneficiary have not Account");
        require(msg.value> 0,"Please select valid Amount");
        DigiAccount[_address].ownerBalance +=_amount;
        require(msg.value> 0,"Please select valid Amount");
        DigiAccount[msg.sender].ownerBalance -=_amount;
        emit addFunds (msg.sender,msg.value,block.timestamp);
        return true;
    }
    function checkAccountBalance() public view returns (uint){
        return DigiAccount[msg.sender].ownerBalance;
    }
    function withdrawAmount(address payable _address, uint _amount) public returns(bool){
             require(DigiAccount[msg.sender].ownerBalance >= _amount,"You have unsufficent balance");
             DigiAccount[msg.sender].ownerBalance -= _amount;
             _address.transfer(_amount);
             DigiAccount[_address].ownerBalance += _amount;
            emit withdrawFunds (msg.sender, _address, _amount, block.timestamp);
            return true;
    }

}