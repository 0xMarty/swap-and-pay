pragma solidity 0.8.10;

interface IRouter {
    function swapExactTokensForETH(uint amountIn, uint amountOutMin, address[] calldata path, address to, uint deadline)
        external
        returns (uint[] memory amounts);
}

contract PayAndSwap {

    address immutable public owner;

    constructor (address _owner) {
        owner = _owner;
    }

    function swapAndPay(
        address payable _payee,
        address _router,
        address[] calldata _path,
        uint _amount,
        uint _minETH
    ) external {
        require(msg.sender == owner, "not owner");

        IRouter(_router).swapExactTokensForETH(_amount, _minETH, _path, address(this), block.timestamp + 10);

        _payee.transfer(address(this).balance);

    }


}