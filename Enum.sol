 pragma solidity >=0.7.0 <0.8.0;
contract Testenum{
   enum  Myenum {def,a,b}
  Myenum public m=Myenum.b;

  
  uint public a=block.timestamp;
  uint public  count=0;
  function getNow()  public view returns( uint )
  {
   
    return count;
  }
  function change() public
  {
       uint  n=block.timestamp;
      if(n>a+10 seconds)
      {
     count++;
     a=n;
     }
     
  }
}
