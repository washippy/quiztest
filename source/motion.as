import fl.motion.AnimatorFactory;
import fl.motion.MotionBase;
import flash.filters.*;
import flash.geom.Point;
var __motion_sFLIP:MotionBase;
if(__motion_sFLIP == null) {
    import fl.motion.Motion;
    __motion_sFLIP = new Motion();
    __motion_sFLIP.duration = 33;

    // Call overrideTargetTransform to prevent the scale, skew,
    // or rotation values from being made relative to the target
    // object's original transform.
    // __motion_sFLIP.overrideTargetTransform();

    // The following calls to addPropertyArray assign data values
    // for each tweened property. There is one value in the Array
    // for every frame in the tween, or fewer if the last value
    // remains the same for the rest of the frames.
    __motion_sFLIP.addPropertyArray("x", [0,-9.38904,-18.7795,-28.1641,-37.5612,-46.9478,-56.3394,-65.7349,-75.1183,-84.5155,-93.9033,-103.3]);
    __motion_sFLIP.addPropertyArray("y", [0,0.690772,1.38165,2.07209,2.76346,3.45405,4.14501,4.83626,5.52661,6.21798,6.90867,7.6,7.6,7.6,7.6,7.6,7.6,7.6,7.6,7.6,7.6,7.6,7.6,7.6,7.6,7.6,7.6,7.6,7.6,7.6,7.6,7.6,7.6]);
    __motion_sFLIP.addPropertyArray("scaleX", [1.000000,0.678930,0.348338,0.006780,-0.347618,-0.717379,-1.106044,-1.518895,-1.964509,-2.458855,-3.040416,-4.001890,-4.001890,-4.001890,-4.001890,-4.001890,-4.001890,-4.001890,-4.001890,-4.001890,-4.001890,-4.001890,-4.001890,-4.001890,-4.001890,-4.001890,-4.001890,-4.001890,-4.001890,-4.001890,-4.001890,-4.001890,-4.001890]);
    __motion_sFLIP.addPropertyArray("scaleY", [1.000000,1.272899,1.545798,1.818697,2.091596,2.364495,2.637394,2.910293,3.183192,3.456091,3.728991,4.001890]);
    __motion_sFLIP.addPropertyArray("skewX", [0,0,0,0,0,0,0,0,0,0,0,0]);
    __motion_sFLIP.addPropertyArray("skewY", [0,0,0,0,0,0,0,0,0,0,0,0]);
    __motion_sFLIP.addPropertyArray("rotationConcat", [90,90,90,90,90,90,90,90,90,90,90,90]);
    __motion_sFLIP.addPropertyArray("blendMode", ["normal"]);

    // Create an AnimatorFactory instance, which will manage
    // targets for its corresponding Motion.
    var __animFactory_sFLIP:AnimatorFactory = new AnimatorFactory(__motion_sFLIP);
    __animFactory_sFLIP.transformationPoint = new Point(0.510260, 0.506780);

    // Call the addTarget function on the AnimatorFactory
    // instance to target a DisplayObject with this Motion.
    // The second parameter is the number of times the animation
    // will play - the default value of 0 means it will loop.
    // __animFactory_sFLIP.addTarget(<instance name goes here>, 0);
}
