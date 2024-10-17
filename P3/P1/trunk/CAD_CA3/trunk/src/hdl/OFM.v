module OFM(clk, address, wrData, wr, done, number);
	input clk, done;
	input[31:0] number;
	input[8:0] address;
	input[31:0] wrData;
	input wr;
	reg [31:0] mem[0:256];

	always@(posedge clk)
	begin
		if(wr)
		begin
			mem[address] = wrData;
		end
	end

	integer file, i;
	initial 
	begin
		wait(done);
		file = $fopen($sformatf("file/output%0d.txt", number+1), "w");

			$display("Number is: %d", number);
			for (i = 0; i < 256; i=i+1)
			begin
				$fwrite(file, "%08x\n", mem[i]);
			end
			$fclose(file);
		end



	
endmodule
