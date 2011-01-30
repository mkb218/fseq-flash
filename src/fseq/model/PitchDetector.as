package fseq.model {

/**
 *	Class description.
 *
 *	@langversion ActionScript 3.0
 *	@playerversion Flash 10.0
 *
 *	@author Zach Archer
 *	@since  20110108
 */

import flash.display.*;
import flash.events.*;
import flash.geom.*;
import caurina.transitions.Tweener;
import com.zacharcher.color.*;
import com.zacharcher.math.*;
import fseq.controller.*;
import fseq.events.*;
import fseq.model.*;
import fseq.net.audiofile.*;
import fseq.view.*;

public class PitchDetector extends Object
{
	//--------------------------------------
	// CLASS CONSTANTS
	//--------------------------------------
	
	//--------------------------------------
	//  CONSTRUCTOR
	//--------------------------------------
	public function PitchDetector( inParser:BaseParser, inLowerLimit:Number, inUpperLimit:Number ) {
		_pitches = new Vector.<Number>( Const.FRAMES, true );
		_parser = inParser;
		_lowerLimit = inLowerLimit;
		_upperLimit = inUpperLimit;
	}
	
	//--------------------------------------
	//  PRIVATE VARIABLES
	//--------------------------------------
	private var _parser :BaseParser;
	
	private var _pitches :Vector.<Number>;
	private var _lowerLimit :Number;
	private var _upperLimit :Number;
	private var _index :int = 0;
	
	//--------------------------------------
	//  GETTER/SETTERS
	//--------------------------------------
	public function get isComplete() :Boolean { return _index >= Const.FRAMES; }
	public function get index() :int { return _index; }
	
	//--------------------------------------
	//  PUBLIC METHODS
	//--------------------------------------
	public function pitchAt( frame:int ) :Number {
		return _pitches[frame];
	}
	
	// Using time domain pitch detection (autocorrelation) for now.
	// Returns the amount of time required for this detection step.
	public function detectNext() :Number {
		var start:Date = new Date();
		
		var windowWidth:int = Math.round( Const.SAMPLE_RATE / _lowerLimit );
		var samps:Vector.<Number> = _parser.getMonoSamplesAtProgress( Number(_index)/Const.FRAMES, windowWidth*2 );		
		
		var bestComb:int = 0;
		var bestPower:Number = -999999;
		
		// Start by testing the lowest allowed pitch, work to the highest
		var combLow:int = windowWidth;
		var combHigh:int = Math.ceil( Const.SAMPLE_RATE / _upperLimit );
		for( var comb:int=combLow; comb>=combHigh; comb-- ) {
			var power:Number = 0;
			for( var w:int=0; w<windowWidth; w++ ) {
				power += samps[w] * samps[w+comb];
			}
			
			if( power > bestPower ) {
				bestPower = power;
				bestComb = comb;
			}
		}
		
		_pitches[_index] = Const.SAMPLE_RATE / bestComb;
		trace("Pitch:", _index, _pitches[_index]);
		
		_index++;
		
		var end:Date = new Date();
		return (end.time - start.time) * (1.0/1000);	// Convert milliseconds to seconds
	}
	
	//--------------------------------------
	//  EVENT HANDLERS
	//--------------------------------------
	
	//--------------------------------------
	//  PRIVATE & PROTECTED INSTANCE METHODS
	//--------------------------------------
	
}

}
