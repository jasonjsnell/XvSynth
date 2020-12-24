//
//  XvLFO.swift
//  XvSynth
//
//  Created by Jason Snell on 10/5/20.
//

import Foundation
import XvUtils
import XvDataMapping

public class XvLFO {
    
    public var value:Double {
        get { return wave.value(withPhaseShift: phaseShift) }
    }
    public var zeroBaseline:Double {
        get { return wave.zeroBaseline(withPhaseShift: phaseShift) }
    }
    public var phaseShift:Double = 0.0
    
    
    //MARK: Speed
    fileprivate var _speed:Double = 1.0
    
    //set wave frequency with speed * multiplier
    public var speed:Double {
        get { return _speed }
        set {
            _speed = newValue
            wave.frequency = _speed * _multiples[_multipier-1]
        }
    }
    
    //MARK: Multiplier
    fileprivate let MULTIPLES_MIN:Int = 1
    fileprivate let MULTIPLES_MAX:Int = 12
    fileprivate let _multiples:[Double]
    fileprivate var _multipier:Int = 1
    fileprivate var _multiplierAttenuator:XvAttenuator
    public var multiplier:Int {
        get { return _multipier }
        set {
            _multipier = _multiplierAttenuator.attenuate(value: newValue)
            wave.frequency = _speed * _multiples[_multipier-1]
        }
    }
    
    //MARK: Depth
    //LFO depth is wave amplitude
    public var depth:Double {
        get {
            return wave.amplitude
        }
        set {
            wave.amplitude = newValue
        }
    }
    
    //an LFO requires a oscillator wave
    public var wave:XvWave
    
    public init(wave:XvWave){
        
        self.wave = wave
        
        _multiplierAttenuator = XvAttenuator(min: Double(MULTIPLES_MIN), max: Double(MULTIPLES_MAX))
        _multiples = [1] + Number.getGeometricSeries(exponent: 2.0, seriesLength: MULTIPLES_MAX)
    }
    
    //pass to wave
    public func refresh(){
        wave.refresh()
    }
}
