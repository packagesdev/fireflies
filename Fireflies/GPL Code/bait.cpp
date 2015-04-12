#include "bait.h"
#include "modes.h"
#include "scene.h"
#include <iostream>


Bait::Bait(Scene * inScene)
    : Arrow()
{
    age = rand_real(0., 10.);
    fuzz = rand_real(0.7, 1.4);
    glow = false;
    attractor = 0;
    bait_start_mode(inScene,this, BMODE_NORMAL);

    hsv[0] = 30.0*rand_int(0, 12); // initial hue
    turn_delay = rand_real(1., 4.);
    turn_when = age + rand_real(0.5, turn_delay);
    pos = Vec3(
	    rand_real(-world[0], world[0]),
	    rand_real(-world[1], world[1]),
	    rand_real(-world[2], world[2]));
    velocity = bspeed*unit_vec(-pos);

    for (int i = 0; i < 3; i++) {
	if (rand_int(0, 1)==0)	accel[i] = -baccel;
	else			accel[i] = baccel;
    }

    set_color();

#ifdef DEBUG
    std::cerr << "bait: " << bspeed << " and " << baccel
    << "\tflies: " << fspeed << " and " << faccel << std::endl;
#endif
}

void Bait::draw(Scene * inScene)
{
    if (!inScene->draw_bait)
	return;

    glPushMatrix();
    Arrow::draw(inScene);
    glPopMatrix();
}

void Bait::elapse(Scene * inScene,double t)
{
    hsv[0] += hue_rate*t;
    age += t;

    if (age >= mode_when)
	bait_start_mode(inScene,this, mode_next);
    while (stop_timer.is_ready(age))
	bait_stop_mode(inScene,this, stop_timer.pop());

    calc_accel();
    velocity += accel*t;
    clamp_vec(velocity, bspeed);
    pos += velocity*t;

    point(velocity);
    set_color();
}

void Bait::calc_accel()
{
    if (attractor) {
	accel = baccel*unit_vec((*attractor) - pos);
	return;
    }

    // time to turn
    if (age >= turn_when) {
	for (int i = 0; i < 3; i++) {
	    if (rand_int(0, 1) == 0)
		accel[i] = -SIGN(accel[i])*baccel;
	}
	turn_when = age + rand_real(0.5, turn_delay);
    }

    for (int i = 0; i < 3; i++) {
	if (pos[i] < -world[i])		accel[i] = baccel;
	else if (pos[i] > world[i])	accel[i] = -baccel;
    }
}

void Bait::set_color()
{
    // keep everything as before

    // clamp to my range
    while (hsv[0] > 360.f)
	hsv[0] -= 360.f;
    while (hsv[0] < 0.f)
	hsv[0] += 360.f;

    color = hsv_to_rgb(hsv);
}
