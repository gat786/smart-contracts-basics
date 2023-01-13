// SPDX-License-Identifier: MIT
pragma solidity >=0.8.7;
pragma abicoder v2;

/**
 * THIS IS AN EXAMPLE CONTRACT THAT USES UN-AUDITED CODE.
 * DO NOT USE THIS CODE IN PRODUCTION.
 */
interface numberComparison {
    function isSameNum(uint a, uint b) external view returns (bool);
}


contract HelloWorld {
    string public message;

    constructor(string memory initialMessage) {
        message = initialMessage;
    }

    function updateMessage(string memory newMessage) public {
        message = newMessage;
    }
}
