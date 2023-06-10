enum 50006 "MidJourney Aspect Ratio" implements "IMidJourney Aspect Ratio"
{
    Extensible = true;
    DefaultImplementation = "IMidJourney Aspect Ratio" = "MidJourney AR - Square";

    value(1; Square)
    {
        Implementation = "IMidJourney Aspect Ratio" = "MidJourney AR - Square";
    }
    value(2; Portrait)
    {
        Implementation = "IMidJourney Aspect Ratio" = "MidJourney AR - Portrait";
    }
    value(3; Landscape)
    {
        Implementation = "IMidJourney Aspect Ratio" = "MidJourney AR - Landscape";
    }
}