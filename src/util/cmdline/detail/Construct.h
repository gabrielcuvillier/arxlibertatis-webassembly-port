/*
 * Copyright 2013-2014 Arx Libertatis Team (see the AUTHORS file)
 *
 * This file is part of Arx Libertatis.
 *
 * Original source is copyright 2010 - 2011. Alexey Tsoy.
 * http://sourceforge.net/projects/interpreter11/
 *
 * Boost Software License - Version 1.0 - August 17th, 2003
 *
 * Permission is hereby granted, free of charge, to any person or organization
 * obtaining a copy of the software and accompanying documentation covered by
 * this license (the "Software") to use, reproduce, display, distribute,
 * execute, and transmit the Software, and to prepare derivative works of the
 * Software, and to permit third-parties to whom the Software is furnished to
 * do so, all subject to the following:
 *
 * The copyright notices in the Software and this entire statement, including
 * the above license grant, this restriction and the following disclaimer,
 * must be included in all copies of the Software, in whole or in part, and
 * all derivative works of the Software, unless such copies or derivative
 * works are solely in the form of machine-executable object code generated by
 * a source language processor.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE, TITLE AND NON-INFRINGEMENT. IN NO EVENT
 * SHALL THE COPYRIGHT HOLDERS OR ANYONE DISTRIBUTING THE SOFTWARE BE LIABLE
 * FOR ANY DAMAGES OR OTHER LIABILITY, WHETHER IN CONTRACT, TORT OR OTHERWISE,
 * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
 * DEALINGS IN THE SOFTWARE.
 */

#ifndef ARX_UTIL_CMDLINE_DETAIL_CONSTRUCT_H
#define ARX_UTIL_CMDLINE_DETAIL_CONSTRUCT_H

#include "util/cmdline/CommandLineException.h"

namespace util { namespace cmdline {

template <typename T, typename Alloc>
class ellipsis;

template <typename T>
struct optional;

template <typename SourceType, typename R>
R construct(SourceType & arg , const R * = 0) {
	
	if(arg.empty()) {
#if !defined(__EMSCRIPTEN__)
		throw error(error::invalid_arg_count, "not enough arguments");
#endif
	}
	
	R ret(arg.template front<R>());
	arg.pop();
	return ret;
}

template <typename SourceType, typename P, typename Alloc>
ellipsis<P, Alloc> construct(SourceType & arg, const ellipsis<P, Alloc> * = 0) {
	
	ellipsis<P, Alloc> ret;
	
	while(!arg.opt_empty()) {
		ret.push_back(construct(arg, static_cast<const P *>(0)));
	}
	
	return ret;
}

template <typename SourceType, typename T>
optional<T> construct(SourceType & arg, const optional<T> * = 0) {
	
	if(arg.opt_empty()) {
		return optional<T>();
	}
	
	optional<T> ret(construct(arg, static_cast<const T *>(0)));
	return ret;
}

} } // namespace util::cmdline

#endif // ARX_UTIL_CMDLINE_DETAIL_CONSTRUCT_H
