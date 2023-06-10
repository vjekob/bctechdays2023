enum 50007 "MidJourney Lighting" implements "IMidJourney Lighting"
{
    Extensible = true;
    DefaultImplementation = "iMidJourney Lighting" = "MJ Lighting - None";

    value(1; None) { implementation = "iMidJourney Lighting" = "MJ Lighting - None"; }
    value(2; Sunshine) { implementation = "iMidJourney Lighting" = "MJ Lighting - Sunshine"; }
    value(3; Cinematic) { implementation = "iMidJourney Lighting" = "MJ Lighting - Cinematic"; }

}