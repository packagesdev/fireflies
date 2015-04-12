#include "arrow.h"
#include "scene.h"

// Draw a wireframe axis-aligned box whose opposite corners are given by the
// points 'min' and 'max'.
void draw_box(const Vec3& min, const Vec3& max)
{
    glBegin(GL_LINE_LOOP);
    glVertex3d(min[0],min[1],min[2]); glVertex3d(min[0],max[1],min[2]);
    glVertex3d(max[0],max[1],min[2]); glVertex3d(max[0],min[1],min[2]);
    glEnd();
    
    glBegin(GL_LINE_LOOP);
    glVertex3d(min[0],min[1],max[2]); glVertex3d(min[0],max[1],max[2]);
    glVertex3d(max[0],max[1],max[2]); glVertex3d(max[0],min[1],max[2]);
    glEnd();
    
    glBegin(GL_LINES);
    glVertex3d(min[0],min[1],min[2]); glVertex3d(min[0],min[1],max[2]);
    glVertex3d(min[0],max[1],min[2]); glVertex3d(min[0],max[1],max[2]);
    glVertex3d(max[0],max[1],min[2]); glVertex3d(max[0],max[1],max[2]);
    glVertex3d(max[0],min[1],min[2]); glVertex3d(max[0],min[1],max[2]);
    glEnd();
}

void Arrow::draw(Scene * inScene)
{
    glColor4fv(color);
    apply_transform();

    glBegin(GL_TRIANGLE_FAN); // the front pyramid
    glVertex3d(0., 0., inScene->fsize*3); // height
    glVertex3d(inScene->fsize, 0., 0.);
    glVertex3d(0., -inScene->fsize, 0.);
    glVertex3d(-inScene->fsize, 0., 0.);
    glVertex3d(0., inScene->fsize, 0.);
    glEnd();

    glBegin(GL_TRIANGLE_FAN); // the butt pyramid
    glVertex3d(0., 0., -inScene->fsize*2); // height
    glVertex3d(inScene->fsize, 0., 0.);
    glVertex3d(0., -inScene->fsize, 0.);
    glVertex3d(-inScene->fsize, 0., 0.);
    glVertex3d(0., inScene->fsize, 0.);
    glEnd();
}

void Arrow::point(Vec3 dir)
{
    double angle = acos(Vec3(0, 0, 1)*unit_vec(dir));
    rot_axis = unit_vec(cross(Vec3(0, 0, 1), dir));
    rot_angle = RAD_TO_DEG(angle);
}
