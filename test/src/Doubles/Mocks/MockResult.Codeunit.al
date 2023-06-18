codeunit 50209 "Mock Result" implements IMidjourneyResult
{
    var
        _invocationCount: Integer;
        _failsWithError: Text;
        _failsWithUnknown: Boolean;
        _lastStatus: Enum "Midjourney Request Status";

    procedure SetFailsWithError(failsWithError: Text)
    begin
        _failsWithError := failsWithError;
    end;

    procedure SetFailsWithUnknown()
    begin
        _failsWithUnknown := true;
    end;

    procedure Result(TaskId: Text; MidjourneySend: Interface IMidjourneySend) Result: Record "Midjourney Result" temporary;
    begin
        Result.Status := _lastStatus;

        case _lastStatus of
            "Midjourney Request Status"::WaitingToStart:
                _lastStatus := "Midjourney Request Status"::Pending;
            "Midjourney Request Status"::Pending:
                _lastStatus := "Midjourney Request Status"::Paused;
            "Midjourney Request Status"::Paused:
                case true of
                    _failsWithUnknown:
                        _lastStatus := "Midjourney Request Status".FromInteger(999);
                    _failsWithError <> '':
                        begin
                            Result.Status := "Midjourney Request Status"::Error;
                            Result."Error Message" := _failsWithError;
                        end;
                    else
                        _lastStatus := "Midjourney Request Status"::Running;
                end;
            "Midjourney Request Status"::Running:
                begin
                    _invocationCount += 1;
                    Result.Percentage := _invocationCount * 10;
                    Result.Status := "Midjourney Request Status"::Running;
                    if Result.Percentage = 100 then begin
                        Result.Status := "Midjourney Request Status"::Done;
                        Result.URL := 'https://vjeko.com/';
                    end;
                end;
        end;
    end;
}
