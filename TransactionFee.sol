// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract TransactionFee {
    address public owner = 0xb2e4c6f13258c4dd3002e2e476385b26d6daf920;
    uint256 public feePercent = 2;

    event Transfer(address indexed from, address indexed to, uint256 value);
    event FeePaid(address indexed from, address indexed to, uint256 value);

    function transfer(address to, uint256 amount) public returns (bool) {
        uint256 fee = (amount * feePercent) / 100;
        uint256 amountAfterFee = amount - fee;

        require(amountAfterFee + fee == amount, "Invalid fee calculation");

        // Transfer the amount after fee to the recipient
        payable(to).transfer(amountAfterFee);
        emit Transfer(msg.sender, to, amountAfterFee);

        // Transfer the fee to the owner
        payable(owner).transfer(fee);
        emit FeePaid(msg.sender, owner, fee);

        return true;
    }

    // Function to receive Ether. msg.data must be empty
    receive() external payable {}

    // Fallback function is called when msg.data is not empty
    fallback() external payable {}
}
