pragma solidity ^0.8.15;

import "openzeppelin-contracts/token/ERC20/ERC20.sol";

 

contract MorkNOTE is ERC20 {

    address private admin;

    constructor() ERC20('NOTE', 'NOTE') {
       admin = msg.sender;
    }

    function mint(address _to, uint256 _amount) external onlyAdmin {
    //solhint-disable-next-line
         _mint(_to, _amount);
    }

    function decimals() public view virtual override returns (uint8) {
      return 18;
    }

    modifier onlyAdmin() {
    require(msg.sender == admin, 'Only Admin');
    _;
  }


}