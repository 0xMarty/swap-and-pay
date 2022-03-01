pragma solidity 0.8.10;

interface IOnChainPayroll {
    function pay(address payable _payee) payable external;
}

interface IRouter {
    function swapExactTokensForETH(uint amountIn, uint amountOutMin, address[] calldata path, address to, uint deadline)
        external
        returns (uint[] memory amounts);
}

contract PayAndSwap {

    IOnChainPayroll public immutable onChainPayroll = IOnChainPayroll(0xa86ED120105accfa060E98169c6e538A33CBB3e2);

    address payable immutable public owner;

    constructor (address payable _owner) {
        owner = _owner;
    }

    function swapAndPay(
        address _router,
        address[] calldata _path,
        uint _amount,
        uint _minETH
    ) external {
        require(msg.sender == owner, "not owner");

        IRouter(_router).swapExactTokensForETH(_amount, _minETH, _path, address(this), block.timestamp + 10);

        owner.transfer(address(this).balance);




    }


}