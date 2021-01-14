
pragma solidity >=0.7.0 <0.8.0;
contract Movie
{
    address payable owner;
    uint constant public price=2* 10**18 wei;
    uint  public tickets=5;
   mapping(address=>uint) public  buyers;
 // uint public a ;
  constructor()
  {
   owner=msg.sender;
     // a= address(this).balance;
  }
  function  buy(uint ticket) public payable check(ticket)
  {
   
     buyers[msg.sender]+=ticket;
     tickets-=ticket;
    owner.transfer(msg.value);
    //a= address(this).balance;
     if(tickets==0)
     selfdestruct(owner);
  }
  modifier check(uint ticket) 
  {
      require(ticket<=tickets,"tickets not available");
      require(msg.value==ticket*price,"insufficient funds");
     _; 
  }
}

