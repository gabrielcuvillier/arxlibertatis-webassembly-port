/*
 * Copyright 2016 Arx Libertatis Team (see the AUTHORS file)
 *
 * This file is part of Arx Libertatis.
 *
 * Arx Libertatis is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * Arx Libertatis is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with Arx Libertatis.  If not, see <http://www.gnu.org/licenses/>.
 */
#ifndef ARX_GRAPHICS_RAYCAST_H
#define ARX_GRAPHICS_RAYCAST_H

#include "math/Types.h"

struct RaycastResult {
	int hit;
	Vec3f pos;
	
	RaycastResult(int hit, Vec3f pos)
		: hit(hit)
		, pos(pos)
	{ }
};

bool RaycastLightFlare(const Vec3f & start, const Vec3f & end);
RaycastResult RaycastLine(const Vec3f & start, const Vec3f & end);


void RaycastDebugClear();
void RaycastDebugDraw();

#endif // ARX_GRAPHICS_RAYCAST_H