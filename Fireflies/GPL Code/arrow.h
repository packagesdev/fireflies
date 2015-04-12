#ifndef _Arrow_H
#define _Arrow_H

#define DEG_TO_RAD(angle) (angle*M_PI/180.0)
#define RAD_TO_DEG(angle) (angle*180.0/M_PI)

#include "control.h"
#include "utils.h"

class Scene;

class Arrow : public Control
{
public:
    hsvColor hsv;
    rgbColor color;
    Vec3 velocity;	// current velocity
    Vec3 accel;		// current acceleration

    Arrow() : hsv(0.0f, 0.8f, 0.8f, 1.0f) {}
    virtual ~Arrow() {}

    // draw the Arrow
    virtual void draw(Scene * inScene);
    // let t seconds elapse
    virtual void elapse(Scene * inScene,double t) = 0;
    // point me in direction of 'dir'.
    void point(Vec3 dir);
};

void draw_box(const Vec3& min, const Vec3& max);

#endif // Arrow.h
