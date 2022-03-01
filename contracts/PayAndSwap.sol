pragma solidity 0.8.10;

interface IRouter {
    function swapExactTokensForETH(uint amountIn, uint amountOutMin, address[] calldata path, address to, uint deadline)
        external
        returns (uint[] memory amounts);
}

contract PayAndSwap {

    uint public ethPayed;

    address immutable public owner;
    address immutable public WETH = 0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2;

    /// @notice Amount of eth address has recieved
    mapping(address => uint) public addressToPaid;
    mapping(address => uint) public tokensSwaped;

    constructor (address _owner) {
        owner = _owner;
    }

    function swapAndPay(
        address payable _payee,
        address _router,
        address _token,
        uint _amount,
        uint _minETH
    ) external {
        require(msg.sender == owner, "not owner");

        address[] memory path = new address[](2);
        path[0] = _token;
        path[1] = WETH;

        IRouter(_router).swapExactTokensForETH(_amount, _minETH, path, address(this), block.timestamp + 10);
        
        ethPayed += address(this).balance;
        addressToPaid[_payee] += address(this).balance;
        tokensSwaped[_token] += _amount;

        _payee.transfer(address(this).balance);
    }




}