function [data_mentah] = readFile(filename)
    data_mentah = xlsread(filename);
end