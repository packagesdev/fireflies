#ifndef _TAIL_H
#define _TAIL_H

#include <OpenGL/gl.h>
#include "utils.h"
#include "gfx/vec3.h"
#include <deque>

class Firefly;

class Scene;

class Tail
{
    struct Link {
	Vec3 pos;	// position of this link
	rgbColor color;	// color
	double age;	// how long this link has existed (in seconds)
	bool glow;	// glow = wider size and higher alpha
	Link(Vec3 _pos, rgbColor _color, bool _glow)
	    : pos(_pos), color(_color), age(0), glow(_glow) {}
    };
    std::deque<Link> links;
public:
    Firefly *owner;	// the firefly I'm attached to

    // Tail(
    //	the firefly we're attached to)
    Tail(Firefly *_owner);
    virtual ~Tail() {}

    // draw the tail
    // returns: true if we're a dead tail, false otherwise
    virtual void draw(Scene * inScene);
    // let t seconds elapse
    virtual bool elapse(Scene * inScene,double t);
};

#endif // tail.h
