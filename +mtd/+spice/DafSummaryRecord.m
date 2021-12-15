classdef DafSummaryRecord
    properties (SetAccess = private)
        next double
        prev double
        nsum double
        summaries (:, :) uint8
        names (:, 1) string
    end

    methods
        function this = DafSummaryRecord(ss, nc, sumDoubles, nameDoubles)
            this.next = sumDoubles(1);
            this.prev = sumDoubles(2);
            this.nsum = sumDoubles(3);
            sumData = typecast(sumDoubles(4:end), 'uint8');
            nameData = typecast(nameDoubles, 'uint8');
            this.summaries = zeros(this.nsum, 8*ss, 'uint8');
            this.names = strings(this.nsum, 1);

            for k = 1:this.nsum
                this.summaries(k, :) = sumData(8*ss*(k-1)+1:8*ss*k);
                this.names(k) = strip(string(char(nameData(nc*(k-1)+1:nc*k)')));
            end
        end
    end
end