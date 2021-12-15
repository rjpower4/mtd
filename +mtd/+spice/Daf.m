classdef Daf < handle
    properties (SetAccess = private)
        idWord string
        nDouble int32
        nInteger int32
        internalDescription string
        initialSummary int32
        finalSummary int32
        firstFree int32
        binaryFormat string
%     end
% 
%     properties (Access = private)
        m
    end

    methods
        function this = Daf(path)
            if ~isfile(path)
                error("Cannot open file: %s", path);
            end

            % Read the record
            fid = fopen(path, "rb");
            fileRecordBytes = fread(fid, 1024, "uint8=>uint8");
            fclose(fid);

            % Get File Record Data
            this.idWord = strip(string(char(fileRecordBytes(1:8))'));
            this.nDouble = typecast(fileRecordBytes(9:12), 'int32');
            this.nInteger = typecast(fileRecordBytes(13:16), 'int32');
            this.internalDescription = strip(string(char(fileRecordBytes(17:76))'));
            locs = typecast(fileRecordBytes(77:88), 'int32');
            this.initialSummary = locs(1);
            this.finalSummary = locs(2);
            this.firstFree = locs(3);
            this.binaryFormat = strip(string(char(fileRecordBytes(89:96))'));

            % Create memory mapping
            this.m = memmapfile(path, Format="double", Writable=false);
        end

        function r = getRecord(this, recordNumber)
            start = 128 * recordNumber - 127;
            final = 128 * recordNumber;
            r = this.m.Data(start:final);
        end

        function s = getSummaryRecord(this, recordNumber)
            rs = this.getRecord(recordNumber);
            rn = this.getRecord(recordNumber + 1);
            s = mtd.spice.DafSummaryRecord(this.getSummarySize, this.getCharactersPerName, rs, rn);
        end

        function ss = getSummarySize(this)
            %GETSUMMARYSIZE calculate the size of a single summary
            ss = this.nDouble + idivide(this.nInteger + 1, 2);
        end

        function ns = getMaxSummariesPerRecord(this)
            %GETSUMMARYCOUNTPERRECORD get the maximum number of summaries that are in each 
            %summary record
            ns = idivide(125, this.getSummarySize);
        end

        function nc = getCharactersPerName(this)
            %GETCHARACTERSPERNAME get the number of characters in each name in a name
            %record
            nc = 8 * this.getSummarySize;
        end

    end
end