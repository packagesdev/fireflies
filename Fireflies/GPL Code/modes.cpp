#include "modes.h"
#include "bait.h"
#include "scene.h"
#include <iostream>

#define BMODE_WAIT 	rand_real(10., 15.)
#define SMODE_WAIT	rand_real(10., 20.)

void bait_start_mode(Scene * inScene,Bait *b, int mode)
{
    b->mode_next = inScene->bmodes.rand();
    b->mode_when = b->age + BMODE_WAIT;

    switch (mode) {
    case BMODE_NORMAL: // normal mode
	if (b->attractor) {
	    delete b->attractor;
	    b->attractor = 0;
	}
	b->bspeed = b->fuzz*inScene->bspeed;
	b->baccel = b->fuzz*inScene->baccel;
	b->fspeed = b->fuzz*inScene->fspeed;
	b->faccel = b->fuzz*inScene->faccel;

	b->hue_rate = b->fuzz*inScene->hue_rate;
	break;
    case BMODE_STOP: // stop mode
	if (b->attractor || b->bspeed==0) // don't do it if we're already doing it
	    break;
	b->bspeed = 0;
	b->stop_timer.add(mode, b->age + rand_real(2., 3.));
	break;
    case BMODE_ATTRACTOR: // attractor
	if (b->attractor || b->bspeed==0) // don't do it if we're already doing it
	    break;
	b->attractor = new Vec3(b->pos + rand_vec3(-10, 10));
	b->baccel = (b->bspeed*b->bspeed/20.0);
	b->stop_timer.add(mode, b->age + rand_real(5., 10.));
	break;
    case BMODE_RAINBOW: // rainbow mode
	b->hue_rate = rand_int(10, 15)*inScene->hue_rate;
	b->stop_timer.add(mode, b->age + rand_real(10., 15.));
	break;
    case BMODE_GLOW: // glow mode
	b->glow = true;
	b->stop_timer.add(mode, b->age + rand_real(10., 20.));
	break;
    case BMODE_HYPERSPEED: // hyperspeed mode
	b->bspeed = 1.5*inScene->bspeed;
	b->baccel = 1.5*inScene->baccel;
	b->fspeed = 2*inScene->fspeed;
	b->faccel = 3*inScene->faccel;
	b->stop_timer.add(mode, b->age + rand_real(10., 20.));
	break;
    case BMODE_FADED: // faded color mode
	b->hsv[1] = rand_real(0.4, 0.6);
	b->stop_timer.add(mode, b->age + rand_real(10., 20.));
	break;
    }

#ifdef DEBUG
    std::cerr << "baitmode=" << mode << " for "
	<< (b->stop_timer.events.empty() ? 0 : b->stop_timer.events[0].second-b->age)
    << "s\tnext=" << b->mode_next << " in " << b->mode_when-b->age << "s" << std::endl;
#endif
}

void bait_stop_mode(Scene * inScene,Bait* b, int mode)
{
    switch (mode) {
    case BMODE_NOTHING:
    case BMODE_NORMAL:
	return;
	break;
    case BMODE_STOP: // anti stop mode
	b->bspeed = b->fuzz*inScene->bspeed;
	break;
    case BMODE_ATTRACTOR: // anti attractor
	delete b->attractor;
	b->attractor = 0;
	b->baccel = b->fuzz*inScene->baccel;
	break;
    case BMODE_RAINBOW: // anti rainbow mode
	b->hue_rate = b->fuzz*inScene->hue_rate;
	break;
    case BMODE_GLOW: // anti glow mode
	b->glow = false;
	break;
    case BMODE_HYPERSPEED: // anti hyperspeed mode
	b->bspeed = b->fuzz*inScene->bspeed;
	b->baccel = b->fuzz*inScene->baccel;
	b->fspeed = b->fuzz*inScene->fspeed;
	b->faccel = b->fuzz*inScene->faccel;
	break;
    case BMODE_FADED:
	b->hsv[1] = 0.8;
	break;
    }

#ifdef DEBUG
    std::cerr << "\tstopped=" << mode << std::endl;
#endif
}

void scene_start_mode(Scene * inScene,int mode)
{
    inScene->mode_next = inScene->smodes.rand();
    inScene->mode_when = inScene->curtime + SMODE_WAIT;

    // negatives keep them off the modelist
    switch (mode) {
    case SMODE_SWARMS: { // all-swarm mode
	int bmode = inScene->bmodes.rand();
	if (bmode < 0)
	    break;
	for (GLuint i = 0; i < inScene->baits.size(); i++) {
	    inScene->baits[i]->stop_timer.clear(); // clear out any stops
	    bait_start_mode(inScene,inScene->baits[i], BMODE_NORMAL); // set default.
	    bait_start_mode(inScene,inScene->baits[i], bmode);
	}
	break;
	    }
    case SMODE_FLYKILL: { // firefly go byebye
	if (inScene->flies.size() <= inScene->minflies) // not too few
	    break;
	long max = (inScene->flies.size() - inScene->minflies);
	long n = rand_int(max/3, max);
	inScene->rem_flies(n);
    
#ifdef DEBUG
	std::cerr << "deleted " << n << " flies" << std::endl;
#endif
	break;
	    }
    case SMODE_FLYBIRTH: { // hello firefly
	if (inScene->flies.size() >= inScene->maxflies) // not too many
	    break;
	long max = (inScene->maxflies - inScene->flies.size());
	long n = rand_int(max/3, max);
	inScene->add_flies(n);
    
#ifdef DEBUG
	std::cerr << "created " << n << " flies" << std::endl;
#endif
	break;
	    }
    case SMODE_WINDY: // it's getting windy in here!
	inScene->wind_speed *= 3;
	inScene->mode_next = -SMODE_WINDY;
	break;
    case -SMODE_WINDY: // calm the wind down
	inScene->wind_speed /= 3;
	break;
    case SMODE_MATRIX: {// matrix mode
	inScene->matrix = inScene->curtime;
	inScene->matrix_axis = Vec3(rand_int(-1, 1), rand_int(-1, 1), rand_int(-1, 1));
	if (norm2(inScene->matrix_axis) == 0)
	    inScene->matrix_axis = Vec3(0, 1, 0);
	unitize(inScene->matrix_axis);
	inScene->mode_next = -SMODE_MATRIX;
	inScene->mode_when = inScene->curtime + rand_real(4.0, 5.0);
	break;
	    }
    case -SMODE_MATRIX: // anti matrix
	inScene->matrix = -1.0;
	break;
    case SMODE_SWARMSPLIT: { // split mode
	if (inScene->baits.size() >= inScene->maxbaits) // not too many
	    break;
	Bait *b1 = inScene->baits[rand_int(0, inScene->baits.size()-1)];
	Bait *b2 = new Bait(inScene);
	b2->pos = b1->pos;
	inScene->baits.push_back(b2);
	double fpb = (double)inScene->flies.size()/inScene->baits.size();
	int n = rand_int((int)(fpb/4), (int)(fpb/2));
	for (GLuint i = 0; i < inScene->flies.size() && n > 0; i++) {
	    if (inScene->flies[i]->bait == b1) {
		inScene->flies[i]->bait = b2;
		inScene->flies[i]->age = 0.0;
		n--;
	    }
	}
	break;
	    }
    case SMODE_SWARMMERGE: { // merge mode
	if (inScene->baits.size() <= inScene->minbaits)
	    break;
	long i1 = rand_int(0, inScene->baits.size()-1);
	long i2 = rand_other(0, inScene->baits.size()-1, i1);
	Bait *b1 = inScene->baits[i1];
	Bait *b2 = inScene->baits[i2];
	
	for (GLuint i = 0; i < inScene->flies.size(); i++) {
	    if (inScene->flies[i]->bait == b2) {
		inScene->flies[i]->bait = b1;
		inScene->flies[i]->age = 0.0;
	    }
	}
        std::vector<Bait*>::iterator it = inScene->baits.begin();
	for (; it != inScene->baits.end(); it++) {
	    if ((*it) == b2) {
		inScene->baits.erase(it);
		break;
	    }
	}
	delete b2;
	break;
	    }
    }
#ifdef DEBUG
    std::cerr << "scenemode=" << mode << ", next=" << inScene->mode_next << " in "
	 << inScene->mode_when-inScene->curtime << std::endl;
#endif
}
