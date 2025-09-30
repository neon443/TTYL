//
//  AudioEngine.swift
//  TTYL
//
//  Created by neon443 on 30/09/2025.
//

import Foundation
import AVFoundation
import CoreAudio

class AudioEngine: NSObject {
	var audioUnit: AudioComponentInstance?
	var audioQueue: [AudioQueueRef] = []
	
	let bufferSize = 16384
	let bufferCount = 3
	
	override init() {
		super.init()
		
		self.setupQueue()
	}
	
	deinit {
		if let audioUnit {
			let status = AudioOutputUnitStop(audioUnit)
			if status != noErr {
				print("failed to stop audiounit")
			}
		}
		audioUnit = nil
	}
	
	func play(tone freq: Frequency) {
		var buf: Array<CChar> = []
		for i in 0...500 {
			buf.append(CChar(LowTone.`2`.freq.wave(x: Double(i))))
		}
		
		let audioBuffer = AudioBuffer(
			mNumberChannels: UInt32(2),
			mDataByteSize: UInt32(500),
			mData: &buf
		)
		let bufferList = AudioBufferList(
			mNumberBuffers: 1,
			mBuffers: audioBuffer
		)
		
//		TPCircularBufferProduceBytes(
//			&circularBuffer,
//			bufferList.mBuffers.mData,
//			bufferList.mBuffers.mDataByteSize
//		)
	}
	
	func setupQueue() {
		var deviceFormat: AudioStreamBasicDescription = .init(
			mSampleRate: 44100,
			mFormatID: kAudioFormatLinearPCM,
			mFormatFlags: kLinearPCMFormatFlagIsSignedInteger,
			mBytesPerPacket: 4,
			mFramesPerPacket: 1,
			mBytesPerFrame: 4,
			mChannelsPerFrame: 2,
			mBitsPerChannel: 16,
			mReserved: 0
		)
		
		// Set a ~2s buffer based on the negotiated stream format.
//		let bytesPerFrame = Double(streamFormat.mBytesPerFrame)
//		let bytesPerSecond = streamFormat.mSampleRate * bytesPerFrame
//		minBufferBytes = Int32(bytesPerSecond * targetLatencySeconds)
		// Ensure we start in buffering mode.
//		self.buffering = true
		
//		var streamFormat = streamFormat
		//create audio component
		var desc = AudioComponentDescription(
			componentType: kAudioUnitType_Output,
			componentSubType: kAudioUnitSubType_RemoteIO,
			componentManufacturer: kAudioUnitManufacturer_Apple,
			componentFlags: 0,
			componentFlagsMask: 0
		)
		if let comp = AudioComponentFindNext(nil, &desc) {
			let status = AudioComponentInstanceNew(comp, &audioUnit)
			if status != noErr {
				print("error creating new audio component instance new")
				print(status)
				return
			}
		}
		
		guard let audioUnit = audioUnit else { return }
		
		//enable input
		let status = AudioUnitSetProperty(
			audioUnit,
			kAudioUnitProperty_StreamFormat,
			kAudioUnitScope_Input,
			0,
			&deviceFormat,
			UInt32(MemoryLayout.size(ofValue: deviceFormat))
		)
		if status != noErr {
			print("error enabling input")
			print(status)
			return
		}
		
		//setup callbacks
		let setupStatus = AudioUnitSetProperty(
			audioUnit,
			kAudioUnitProperty_SetRenderCallback,
			kAudioUnitScope_Global,
			0,
			nil,
			0
		)
		if setupStatus != noErr {
			print("failed to setup callbacks")
			print(setupStatus)
			return
		}
		
		//init audio unit
		let initStatus = AudioUnitInitialize(audioUnit)
		if initStatus != noErr {
			print("failed to init audio unit")
			print(initStatus)
			return
		}
		
		//start audio unit
		let unitStatus = AudioOutputUnitStart(audioUnit)
		if unitStatus != noErr {
			print("failed to start audio unit")
			print(unitStatus)
			return
		}
	}
	
	func 
}
