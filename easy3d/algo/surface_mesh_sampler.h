/********************************************************************
 * Copyright (C) 2015 Liangliang Nan <liangliang.nan@gmail.com>
 * https://3d.bk.tudelft.nl/liangliang/
 *
 * This file is part of Easy3D. If it is useful in your research/work,
 * I would be grateful if you show your appreciation by citing it:
 * ------------------------------------------------------------------
 *      Liangliang Nan.
 *      Easy3D: a lightweight, easy-to-use, and efficient C++
 *      library for processing and rendering 3D data. 2018.
 * ------------------------------------------------------------------
 * Easy3D is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License Version 3
 * as published by the Free Software Foundation.
 *
 * Easy3D is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program. If not, see <http://www.gnu.org/licenses/>.
 ********************************************************************/

#ifndef EASY3D_ALGO_MESH_SAMPLER_H
#define EASY3D_ALGO_MESH_SAMPLER_H


namespace easy3d {

    class PointCloud;
    class SurfaceMesh;

    /// \brief Sample a surface mesh (near uniformly) into a point cloud.
    /// \class SurfaceMeshSampler easy3d/algo/surface_mesh_sampler.h
    class SurfaceMeshSampler {
    public:
        /// @param num The expected point number, much be greater than the number of vertices of the surface mesh.
        PointCloud *apply(const SurfaceMesh *mesh, int num = 1000000);
    };

} // namespace easy3d

#endif  // EASY3D_ALGO_MESH_SAMPLER_H

