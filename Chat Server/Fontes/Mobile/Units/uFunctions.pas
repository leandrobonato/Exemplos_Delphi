unit uFunctions;

interface

function FormataData(dt: string): string;

implementation

// Formato: 2021-10-09 14:11:28 -->  09/10/2021 14:11
function FormataData(dt: string): string;
begin
    Result := Copy(dt, 9, 2) + '/' + Copy(dt, 6, 2) + '/' + Copy(dt, 1, 4) + ' ' + Copy(dt, 12, 5);
end;


end.
