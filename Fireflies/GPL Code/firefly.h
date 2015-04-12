#ifndef _PARTICLE_H
#define _PARTICLE_H

#include "arrow.h"
#include "tail.h"
#include "bait.h"

class Firefly : public Arrow
{
public:
    Bait *bait;		// the bait I'm after
    Tail *tail;		// my pretty tail
    double age;		// how long I've been alive

    // Firefly(
    //	the bait I'm after,
    //	where to put me,
    //	plus/minus this amount)
    Firefly(Bait *_bait, Vec3 ctr, double spread);
    virtual ~Firefly();

    // draw me and my tail
    virtual void draw(Scene * inScene);
    // let t seconds elapse
    virtual void elapse(Scene *inScene,double t);
    // calculate acceleration
    void calc_accel(Scene * inScene);
    // change colors based on parameters
    void set_color();
};

#endif // Firefly.h
