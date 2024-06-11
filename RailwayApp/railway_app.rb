# frozen_string_literal: true

require_relative 'train'
require_relative 'station'
require_relative 'route'

require 'pry'

st_klg = Station.new(:klg)
st_vln = Station.new(:vln)
st_mns = Station.new(:mns)
st_kzn = Station.new(:kzn)
st_ekb = Station.new(:ekb)
st_omk = Station.new(:omk)
st_nsb = Station.new(:nsb)
st_irk = Station.new(:irk)
st_hbr = Station.new(:hbr)
st_vdv = Station.new(:vdv)

st_msk = Station.new(:msk)

st_arh = Station.new(:arh)
st_vld = Station.new(:vld)
st_yar = Station.new(:yar)
st_tla = Station.new(:tla)
st_orl = Station.new(:orl)
st_krs = Station.new(:krs)
st_rnd = Station.new(:rnd)
st_knd = Station.new(:knd)
st_sci = Station.new(:sci)

route_1 = Route.new(st_klg, st_vdv)
route_1.add_station(st_msk)

train_1 = Train.new('TRN-1', :crg, 20)
train_1.set_route(route_1)
train_1.move_forward

binding.pry
