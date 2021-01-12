pragma solidity >=0.7.0 <0.8.0;
contract Vote
{
    struct Voter
    {
        uint weight;
        bool vote;
        uint8 candidate;
    }
    struct Proposal
    {
        uint votecount;
    }
 Proposal[] public proposal;

    address chairman;
    mapping(address=>Voter) public record;
      uint public length;
    constructor(uint no)
    {
       chairman=msg.sender; 
       record[chairman].weight=2;
       record[chairman].vote=false;
       
     for(uint i=0;i<=no;i++)
     proposal.push(Proposal({votecount: 0}));
     length=proposal.length;
    }
 
   function register(address voter) public
   {
       require(msg.sender==chairman && record[voter].weight==0,"not registered by chairman or already registered");
       record[voter].weight=1;
       record[voter].vote=false;
       
   }
    
    function vote(uint8 candidate) public
    {
        Voter memory v=record[msg.sender];
        require(v.weight!=0,"voter not registered");
        require(!v.vote,"already voted");
        require(candidate<=proposal.length,"invalid candidate");
        v.vote=true;
        v.candidate=candidate;
        proposal[candidate].votecount+=v.weight;
        record[msg.sender]=v;
    }
    function DeclareResult() view public returns(uint, uint)
    {
        uint max=0;
        for(uint i=1;i<proposal.length;i++)
        {
            if(proposal[i].votecount>proposal[max].votecount)
              max=i;
        }
        return(max,proposal[max].votecount);
    }
    
}
