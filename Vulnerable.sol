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
        (bool success, ) = (msg.sender).call{value:amount}("");
        require(success, "Transaction Failed");
        Storage -= amount;                                               //State Variables are being updated after the transaction
        Balances[msg.sender] -= amount;                                  //Attacker benefits from calling this function repeatedly before the state varaibles are updated.
    }
}
