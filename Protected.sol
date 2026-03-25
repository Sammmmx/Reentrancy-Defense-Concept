//SPDX-License_Identifier : MIT

pragma solidity ^0.8.23;

contract vulnerable {

    uint256 Storage;

    mapping(address => uint256) public Balances;

    function deposit() public payable {
        require(msg.value > 0, "Deposit something?");
        Storage += msg.value;
        Balances[msg.sender] += msg.value;
    }

    function withdraw(uint256 amount) public payable {
        require(amount <= Balances[msg.sender], "Asking for outside your balance");
        Storage -= amount;
        Balances[msg.sender] -= amount;
        (bool success, ) = (msg.sender).call{value:amount}("");
        require(success, "Transaction Failed");
    }
}