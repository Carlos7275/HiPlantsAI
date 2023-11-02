<?php

namespace App\Services;

use Illuminate\Bus\Queueable;
use Illuminate\Mail\Mailable;
use Illuminate\Queue\SerializesModels;


class EmailService extends Mailable
{

    use Queueable, SerializesModels;
    public $token;
    public $email;
    public $url;
    public $subject;

    /**
     * Create a new message instance.
     *
     * @return void
     */
    public function __construct($token, $email)
    {
        $this->token = $token;
        $this->email = $email;
    }

    /**
     * Build the message.
     *
     * @return $this
     */
    public function build()
    {
        $this->url = "http://{$_SERVER["HTTP_HOST"]}:4200/recuperarCuenta/" . $this->token;
        $this->subject('Recuperar Cuenta');
        return $this->from("ruizelizaldeyilma@gmail.com", env('MAIL_FROM_NAME'))
            ->view('correo')
            ->Subject('Recuperar Cuenta')
            ->with($this->url);
    }
}
