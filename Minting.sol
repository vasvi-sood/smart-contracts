pragma solidity >=0.7.0 <0.8.0;
contract Mint{
    mapping(address=>uint) public getWalletMoney;
    address public senderAddress;
    uint public amountWithSender=0;
    constructor()
    {
       senderAddress=msg.sender;
    }
    function mint(uint amt) public
    {
     
       amountWithSender+=amt;
       getWalletMoney[senderAddress]=amountWithSender;
    }
    event Transaction(address from, address to,uint amount);
    function send(address sendto, uint amt ) public
    {
        require(!(sendto==senderAddress));
        require(amt<=amountWithSender);
        getWalletMoney[senderAddress]-=amt;
        getWalletMoney[sendto]+=amt;
        amountWithSender-=amt;
        emit Transaction(senderAddress,sendto,amt);
    }
    
    function peekWallet(address ad) view public returns(uint)
    {
        return getWalletMoney[ad];
    }
    
}
