#ifndef _Bait_H
#define _Bait_H

#include "arrow.h"
#include "utils.h"

class Scene;

class Bait : public Arrow
{
public:
    double age;		// timer with random initial value
    double fuzz;	// my little bit of randomness
    double turn_delay;	// max delay before turning (higher = slower changing)
    double turn_when;	// when to change acceleration (referenced from timer)
    int mode_next;	// the next mode to activate
    double mode_when;	// next time to activate a mode (ref timer)
    Timer stop_timer;	// timer for stopping events

    // options
    double bspeed;	// my speed
    double baccel;	// my accel
    double fspeed;	// speed of the fireflies chasing me
    double faccel;	// acceleration of the fireflies chasing me
    double hue_rate;	// my color-cycling rate
    bool glow;		// should tails glow

    Vec3 *attractor;

    Bait(Scene * inScene);

    // draw me
    virtual void draw(Scene * inScene);
    // let t seconds elapse
    virtual void elapse(Scene * inScene,double t);
    // calculate acceleration
    virtual void calc_accel();
    // change colors based on parameters
    void set_color();
};

#endif // Bait.h
