`include "defines.v"

module Branch_CTRLU(

    input [2:0] func3,
    input [1:0] branch, 
    input cf, input zf, input vf, input sf, 
    output reg o  
    );
    
    always @ * begin
        if(branch[1]) o = 1'b1;  
        else if(branch[0]) begin
                case (func3)
                    `BR_BEQ  : o = zf;
                    `BR_BNE  : o = ~zf;
                    `BR_BLT  : o = (sf != vf);
                    `BR_BGE  : o = (sf == vf);
                    `BR_BLTU : o = ~cf;
                    `BR_BGEU : o = cf;
                    default : o =0;
                endcase
        end else o = 0;
    end
    
endmodule
