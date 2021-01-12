pragma solidity >=0.7.0 <0.8.0;
contract Vote
{
    enum stage {init,reg,vote,declare}
    uint start;

   stage public current=stage.init;
   
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
        current=stage.reg;
        start=block.timestamp;
       chairman=msg.sender; 
       record[chairman].weight=2;
       record[chairman].vote=false;
       
     for(uint i=0;i<=no;i++)
     proposal.push(Proposal({votecount: 0}));
     length=proposal.length;
    }
 
 function register(address voter) public checkReg
   {
       require(msg.sender==chairman && record[voter].weight==0,"not registered by chairman or already registered");
       record[voter].weight=1;
       record[voter].vote=false;
      
           
         
       
       
   }
    
    function vote(uint8 candidate) public checkVote
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
    function DeclareResult() view public checkDeclare returns(uint, uint)
    {
        uint max=0;
        for(uint i=1;i<proposal.length;i++)
        {
            if(proposal[i].votecount>proposal[max].votecount)
              max=i;
        }
        assert(max!=0);
        return(max,proposal[max].votecount);
    }
    modifier checkReg
    {
      //  require(current==stage.reg,"registeration period over");
      bool cond=block.timestamp<start+30 seconds;
       if(cond)
      current=stage.reg;
      require(cond,"registeration period over");
     
        _;
    }
     modifier checkVote
    {
        bool cond=(block.timestamp<start+1 minutes) && (block.timestamp>start+30 seconds);
         if(cond)
         current=stage.vote;
       // require(cond,"voting period not started or over");
         require(block.timestamp<start+1 minutes,"voting  period over or not started");
        _;
    }
      modifier checkDeclare
    {
        bool cond=block.timestamp>start+1 minutes;
        
        require(cond,"result period not started");
       // require(current==stage.declare,"declaring period not started ");
        _;
    }
    
}
