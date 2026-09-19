import cocotb 
from cocotb.clock import Clock 
from cocotb.triggers import RisingEdge,Timer 

@cocotb.test
async def self_checking(dut):
    Clock(dut.clk,10,"ns").start()
    
    await reset(dut);
    
    dut.din.value = 250
    dut.set.value = 1
    
    await RisingEdge(dut.clk)
    
    dut.set.value = 0
    
    await Timer(1,"ns")
    
    assert dut.count.value == 250
    
    dut.ena.value = 1
    expucted = 250
    for _ in range(20):
        
        if(expucted==255):
            expucted=0
        else:
            expucted+=1
            
        await RisingEdge(dut.clk)
        await Timer(1,"ns")
            
        assert dut.count.value == expucted
        
        
async def reset(dut):
    # Set initial values for the signals.
    dut.ena.value = 0
    dut.set.value = 0
    dut.din.value = 0

    # Keep the reset signal high for 3 clock cycles.
    dut.rst.value = 1
    for _ in range(3):
        await RisingEdge(dut.clk)
    dut.rst.value = 0