enum 50001 "Midjourney Request Status"
{
    Caption = 'Midjourney Request Status';
    Extensible = false;

    value(0; WaitingToStart)
    {
        Caption = 'Waiting to Start';
    }

    value(1; Pending)
    {
        Caption = 'Pending';
    }

    value(2; Paused)
    {
        Caption = 'Paused';
    }

    value(3; Running)
    {
        Caption = 'Running';
    }

    value(4; Done)
    {
        Caption = 'Done';
    }

    value(5; Error)
    {
        Caption = 'Error';
    }
}
