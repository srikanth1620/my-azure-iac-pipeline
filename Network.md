tracert ? 
----------------------------------------------------------------------------
login to one server and execute tracert dest ip
- tracert 10.3.1.0 (this will show the hop)

UDR (User Defined Route) ? 
----------------------------------------------------------------------------
- going from public -- DMZ --- Private 
- Create Route Table 
- Create Routes 
    - Give destination address (actual destination server private cidr range )
    -  Next hop (Virtual appliance)
    - Next hop address (DMZ ip)
- Attach the route table to public subnet 
- We have do enable ip forwarding in DMZ server 
- We need to set "IPEnableRouter" value to 1 in the DMZ registry (Not sure this required only for windows)
- Now you can see 2 hops in tracert from public to private . Before it will be just one hop 